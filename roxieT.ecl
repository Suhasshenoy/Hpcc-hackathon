#OPTION('obfuscateOutput', TRUE);

import $,std;

mentor := $.extras.projMentorT1;

SampleRec := $.extras.SampleRec;

_FirstName                 := '' : STORED('FirstName', FORMAT(SEQUENCE(1)));

_LastName                  := '' : STORED('LastName', FORMAT(SEQUENCE(2)));

_ZipCode                   := '' :STORED('ZipCode',FORMAT(SEQUENCE(3)));

_Region                    := '':STORED('Region',FORMAT(SEQUENCE(4)));

_Race_Ethnicity            := '':STORED('Race_Ethnicity',FORMAT(SEQUENCE(5)));

_Religion                  := '' : STORED('Religion', FORMAT(SEQUENCE(6), 
                          SELECT('None=None,Christian=Christian,Islam=Islam,Jewish=Jewish,Hindu=Hindu,Buddhist=Buddhist,Other=Other,Spiritual=Spiritual,N/A=N/A')));

_RoleofFaith               := '' : STORED('RoleofFaith', FORMAT(SEQUENCE(7),
                             SELECT('N/A=N/A,Inclusive=Inclusive,Exclusive=Exclusive,Unimportant=Unimportant')));

_AlcoholUse                := '' : STORED('AlcoholUse', FORMAT(SEQUENCE(8),
                             SELECT('None=None,Occasionally=Occasionally,Responsibly=Responsibly,Irresponsibly=Irresponsibly,N/A=N/A')));

_marijuana                 := '' : STORED('marijuana', FORMAT(SEQUENCE(9),
                             SELECT('None=None,Occasionally=Occasionally,Regularly=Regularly,N/A=N/A')));

_cigarettes                := '' : STORED('cigarettes', FORMAT(SEQUENCE(10),
                             SELECT('None=None,Occasionally=Occasionally,Regularly=Regularly,N/A=N/A')));

_vape                      := '' : STORED('vape', FORMAT(SEQUENCE(11),
                             SELECT('None=None,Occasionally=Occasionally,Regularly=Regularly,N/A=N/A')));

_JobRetentionChallenges    := '' : STORED('JobRetentionChallenges', FORMAT(SEQUENCE(12),
                            SELECT('N/A=N/A,Check=Check')));

_DayOff                    := '' : STORED('DayOff', FORMAT(SEQUENCE(13)));

_FavoritePlace             := '' : STORED('FavoritePlace', FORMAT(SEQUENCE(14)));

_Personality               := '' : STORED('Personality', FORMAT(SEQUENCE(15)));

_SocialStyle               := '' : STORED('SocialStyle', FORMAT(SEQUENCE(16),
                            SELECT('N/A=N/A,Introverted=Introverted,Extroverted=Extroverted,Both=Both')));

_SadnessResponse           := '' : STORED('SadnessResponse', FORMAT(SEQUENCE(17)));

_AngerResponse             := '' : STORED('AngerResponse', FORMAT(SEQUENCE(18)));

_ContinuingEducation       := '' : STORED('ContinuingEducation', FORMAT(SEQUENCE(19),
                             SELECT('N/A=N/A,Yes=Yes')));

_SupportNeeds              := '' : STORED('SupportNeeds', FORMAT(SEQUENCE(20)));

_CriminalHistory           := '' : STORED('CriminalHistory', FORMAT(SEQUENCE(21)));

_Children                  := '' : STORED('Children', FORMAT(SEQUENCE(22)));

_BioRelationships          := '' : STORED('BioRelationships', FORMAT(SEQUENCE(23),
                             SELECT('N/A=N/A,Important=Important,Difficult=Difficult,None=None')));

_Sexuality                 := '' : STORED('Sexuality', FORMAT(SEQUENCE(24),
                             SELECT('N/A=N/A,Heterosexual=Heterosexual,Homosexual=Homosexual,Bisexual=Bisexual')));

_GenderIdentity            := '' : STORED('GenderIdentity', FORMAT(SEQUENCE(25),
                             SELECT('Male=Male,Female=Female,Transgender=Transgender,NonBinary=NonBinary')));
                             
_Latitude := 0 :    STORED('Latitude', FORMAT(SEQUENCE(26)));

_Longitude := 0 :    STORED('Longitude', FORMAT(SEQUENCE(27)));

_Distance := 0 :    STORED('Distance', FORMAT(SEQUENCE(28)));




// ERROR message to print if required fields are not submitted by user
if((_FirstName ='' or _distance = 0 or _Latitude = 0 or _Longitude = 0) AND _Religion !='' , FAIL('NOT ENOUGH INPUT'));

SampleDS := DATASET([{_FirstName,_LastName,_ZipCode,_Region,_Race_Ethnicity,_Religion,_RoleofFaith,_AlcoholUse,_marijuana,_cigarettes,_vape,
                    _JobRetentionChallenges,_DayOff,_FavoritePlace,_Personality,_SocialStyle,_SadnessResponse,_AngerResponse,_ContinuingEducation,
                    _SupportNeeds,_CriminalHistory,_Children,_BioRelationships,_Sexuality,_GenderIdentity,_Latitude,_Longitude,_Distance}], 
                    SampleRec);//:persist('~CLASS::TROUBLESHOOTERS::PERSIST::YOUTHINFO',MULTIPLE(-1))


OUTPUT(SampleDS, NAMED('SampleDS'));

// calculates the human review field required in the output for the fields marked as N/A
string hum_ver := IF(_Religion='N/A','Religion ','') + if(_RoleofFaith='N/A','RoleofFaith ','')+IF(_AlcoholUse='N/A','AlcoholUse ','')+
IF(_marijuana='N/A','Marijuana ','')+IF(_cigarettes='N/A','Cigarettes ','')+ IF(_vape='N/A','Vape ','')+
 IF(_JobRetentionChallenges='N/A','JobRetentionChallenges ','')+IF(_DayOff='','DayOff ','')+IF(_FavoritePlace='','FavoritePlace ','')+ 
 IF(_Personality='','Personality ','')+ IF(_SocialStyle='N/A','SocialStyle ','')+ IF(_SadnessResponse='','SadnessResponse ','')
 +IF(_AngerResponse='','AngerResponse ','') + IF(_ContinuingEducation='N/A','ContinuingEducation ','')+ IF(_SupportNeeds='','SupportNeeds ','')+
IF(_CriminalHistory='','CriminalHistory ','')+ IF(_Children='','Children ','')+IF(_BioRelationships='N/A','BioRelationships ','')
+IF(_Sexuality='N/A','Sexuality ','');


distance := $.extras.Distance;
//calling the distance function and adding a distance field to the mentor from the particular youth
projMentorT2 := PROJECT(mentor,
                            TRANSFORM(
                                $.extras.MentorsT1,
                                SELF.distance := distance(_Latitude,_Longitude,LEFT.Latitude,LEFT.Logatitude);
                                SELF := LEFT;
                            ));

//filtering mentors based on distance calculated from longitude and latitude and eliminating mentors who are not in range
projMentorT3 := projMentorT2(distance <= _Distance);

outLayout := $.extras.outLayout;

//since support needs takes multiple fields of mentor ds as input , we split those strings based on commas
_SupportNeedsU := std.str.ToUpperCase(_SupportNeeds);
SET OF STRING supportNeedsSet := STD.Str.SplitWords(_SupportNeedsU, ',',TRUE);

////since criminal history takes multiple fields of mentor ds as input , we split those strings based on commas
_CriminalHistoryU := std.str.ToUpperCase(_CriminalHistory);
SET OF STRING criminalhistorySet :=  STD.Str.SplitWords(_CriminalHistoryU, ',',TRUE);

_ChildrenU      :=  std.str.ToUpperCase(_Children);
SET OF STRING ChildrenSet :=  STD.Str.SplitWords(_ChildrenU, ',',TRUE);

projMentorT4 := PROJECT(projMentorT3, 
    TRANSFORM(outLayout,
        SELF.FullName := LEFT.FullName;

        SELF.Religion := MAP(STD.Str.ToUpperCase(_religion) = 'CHRISTIAN' => 
                         IF(LEFT.Religion_Christian = 0, -200,  LEFT.Religion_Christian ),
                         STD.Str.ToUpperCase(_religion) = 'ISLAM' => 
                         IF(LEFT.Religion_Muslim = 0, -200, LEFT.Religion_Muslim ),
                         STD.Str.ToUpperCase(_religion) = 'JEWISH' => 
                         IF(LEFT.Religion_Jewish = 0, -200, LEFT.Religion_Jewish ),
                         STD.Str.ToUpperCase(_religion) = 'HINDU' => 
                         IF(LEFT.Religion_Hindu = 0, -200, LEFT.Religion_Hindu ),
                         STD.Str.ToUpperCase(_religion) = 'BUDDHIST' => 
                         IF(LEFT.Religion_Buddhist = 0, -200, LEFT.Religion_Buddhist ),
                         STD.Str.ToUpperCase(_religion)= 'OTHER' => 
                         IF(LEFT.Religion_Other = 0, -200, LEFT.Religion_Other),
                         STD.Str.ToUpperCase(_religion) = 'SPIRITUAL' => 
                         IF(LEFT.Religion_Spiritual = 0, -200, LEFT.Religion_Spiritual),
                         STD.Str.ToUpperCase(_religion) = 'NONE' => 
                         IF(LEFT.Religion_None = 0, -200, LEFT.Religion_None ),
                         0);
                            

        SELF.roleoffaith := IF(STD.Str.ToUpperCase(_roleoffaith) = LEFT.RoleofFaith_primary, 0.5 , 0) + 
                            IF(STD.Str.ToUpperCase(_roleoffaith) = LEFT.RoleofFaith_spouse, 0.5 , 0);

        SELF.FavoritePlace := IF(STD.Str.ToUpperCase(_FavoritePlace) = LEFT.FavoritPlace_primary, 0.5 , 0) + 
                            IF(STD.Str.ToUpperCase(_FavoritePlace) = LEFT.FavoritePlace_spouse, 0.5 , 0);

        SELF.Personality := IF(STD.Str.ToUpperCase(_Personality) = LEFT.Personality_primary, 0.5 , 0) +
                            IF(STD.Str.ToUpperCase(_Personality) = LEFT.Personality_spouse, 0.5 , 0);

        SELF.SocialStyle := MAP(STD.Str.ToUpperCase(_SocialStyle) = 'INTROVERTED' => 
                            IF(LEFT.SocialStyle_Introverted = 0,-200, LEFT.SocialStyle_Introverted),
                            STD.Str.ToUpperCase(_SocialStyle) = 'EXTRAVERTED' => 
                            IF(LEFT.SocialStyle_Extraverted = 0,-200, LEFT.SocialStyle_Extraverted),
                            STD.Str.ToUpperCase(_SocialStyle) = 'BOTH' => 
                            IF(LEFT.SocialStyle_Both = 0,-200, LEFT.SocialStyle_Both),0) ;

         SELF.AlcoholUse := MAP(STD.Str.ToUpperCase(_AlcoholUse) = 'OCCASIONALLY' => 
                         IF(LEFT.Alcohol_Occasional = 0, -200, LEFT.Alcohol_Occasional ),
                         STD.Str.ToUpperCase(_AlcoholUse) = 'RESPONSIBLY' => 
                         IF(LEFT.Alcohol_Responsible = 0, -200, LEFT.Alcohol_Responsible),
                         STD.Str.ToUpperCase(_AlcoholUse) = 'IRRESPONSIBLY' => 
                         IF(LEFT.Alcohol_Irresponsible = 0, -200, LEFT.Alcohol_Irresponsible ),0);

        SELF.Smoking := MAP(std.Str.ToUpperCase(_marijuana) = 'OCCASIONALLY' =>  
                        IF(LEFT.Marijuana_Occasional = 0 , -200, LEFT.Marijuana_Occasional),
                        std.Str.ToUpperCase(_marijuana) = 'REGULARLY'=> 
                        IF(LEFT.Marijuana_Regular = 0 , -200, LEFT.Marijuana_Regular),
                        0) + 
                        MAP(std.Str.ToUpperCase(_cigarettes) = 'OCCASIONALLY' =>  
                        IF(LEFT.Cigarettes_Occasional = 0 , -200, LEFT.Cigarettes_Occasional),
                        std.Str.ToUpperCase(_cigarettes) = 'REGULARLY'=> 
                        IF(LEFT.Cigarettes_Regular = 0 , -200, LEFT.Cigarettes_Regular),
                        0) +
                        MAP(std.Str.ToUpperCase(_vape) = 'OCCASIONALLY' =>  
                        IF(LEFT.Vaping_Occasional = 0 , -200, LEFT.Vaping_Occasional),
                        std.Str.ToUpperCase(_vape) = 'REGULARLY'=> 
                        IF(LEFT.Vaping_Regular = 0 , -200, LEFT.Vaping_Regular),
                        0);

        Self.JobRetentionChallenges := if(STD.Str.ToUpperCase(_JobRetentionChallenges)='CHECKED',LEFT.JobRetentionChallenges,0);

        SELF.DayOff := IF(STD.Str.ToUpperCase(_DAYOFF) = LEFT.DayOff_primary, 0.5 , 0) + IF(STD.Str.ToUpperCase(_dayoff) = LEFT.DayOff_spouse, 0.5 , 0);

        self.SadnessResponse := IF(STD.Str.ToUpperCase(_SadnessResponse) = LEFT.SadnessResponse_primary, 0.5 , 0) + 
                                IF(STD.Str.ToUpperCase(_SadnessResponse) = LEFT.SadnessResponse_spouse, 0.5 , 0);

        self.AngerResponse := IF(STD.Str.ToUpperCase(_AngerResponse) = LEFT.AngerResponse_primary, 0.5 , 0) + 
                              IF(STD.Str.ToUpperCase(_AngerResponse) = LEFT.AngerResponse_spouse, 0.5 , 0);

        self.ContinuingEducation :=  if(STD.Str.ToUpperCase(_ContinuingEducation)='YES',LEFT.ContinuingEducation,0);

        self.SupportNeeds := IF('HOLIDAYS' IN supportNeedsSet , IF( left.Supports_Holidays = 0, -200,left.Supports_Holidays),0)  +
                             IF('JOB' IN supportNeedsSet, IF( left.Supports_Job = 0, -200,left.Supports_Job ),0) +
                             IF('PARENTING' IN supportNeedsSet, IF( left.Supports_Parenting = 0, -200, left.Supports_Parenting),0) +
                             IF('MEDICAL' IN supportNeedsSet, IF( left.Supports_Medical =0,-200, left.Supports_Medical),0) +
                             IF('LEGAL' IN supportNeedsSet, IF(left.Supports_Legal =0, -200, left.Supports_Legal ),0) +
                             IF('BUDGETING' IN supportNeedsSet, IF(left.Supports_Budgeting =0,-200, left.Supports_Budgeting),0) +
                             IF('MENTAL HEALTH' IN supportNeedsSet, IF(left.Supports_MentalHealth =0,-200, left.Supports_MentalHealth),0) +
                             IF('RESOURCES' IN supportNeedsSet, IF(left.Supports_Resources =0,-200, left.Supports_Resources),0) +
                             IF('SOCIAL' IN supportNeedsSet, IF(left.Supports_Social =0,-200,left.Supports_Social),0) ;

        self.CriminalHistory := if('ARRESTED' IN criminalhistoryset,IF(LEFT.CriminalHistory_Arrested=0,-200,LEFT.CriminalHistory_Arrested),0)+
                                if('JAIL' IN criminalhistoryset,IF(LEFT.CriminalHistory_Jail=0,-200,LEFT.CriminalHistory_Jail),0)+
                                if('CURRENT PROBATION' IN criminalhistoryset,IF(LEFT.CriminalHistory_CurrentProbation=0,-200,
                                LEFT.CriminalHistory_CurrentProbation),0);

        self.Children        := IF('CARING FOR 1' IN Childrenset , IF( left.Children_Custody1 = 0, -200,left.Children_Custody1),0)  +
                                IF('CARING FOR MULTIPLE' IN Childrenset, IF( left.Children_Custodymultiple = 0, -200,left.Children_Custodymultiple ),0) +
                                IF('1 IN KINCARE' IN Childrenset, IF( left.Children_Kincare1 = 0, -200, left.Children_Kincare1),0) +
                                IF('MULTIPLE IN KINCARE' IN Childrenset, IF( left.Children_Kincaremultiple =0,-200, left.Children_Kincaremultiple),0) +
                                IF('PREGNANT' IN Childrenset, IF(left.Children_Pregnant =0, -200, left.Children_Pregnant ),0) +
                                IF('1 IN WELFARE' IN Childrenset, IF(left.Children_Welfare1 =0,-200, left.Children_Welfare1),0) +
                                IF('MULTIPLE IN WELFARE' IN Childrenset, IF(left.Children_Welfaremultiple =0,-200, left.Children_Welfaremultiple),0);                         

        
        self.BioRelationships := map(std.str.ToUpperCase(_BioRelationships)='IMPORTANT' =>
                                IF(left.Bio_Important=0,-200,left.Bio_Important),
                                std.str.ToUpperCase(_BioRelationships)='DIFFICULT' =>
                                IF(left.Bio_Difficult=0,-200,left.Bio_Difficult),0);

        self.Sexuality :=   map(std.str.ToUpperCase(_Sexuality)='HETEROSEXUAL' =>
                                IF(left.Sexuality_Heterosexual=0,-200,left.Sexuality_Heterosexual),
                                std.str.ToUpperCase(_Sexuality)='HOMOSEXUAL' =>
                                IF(left.Sexuality_Homosexual=0,-200,left.Sexuality_Homosexual),
                                std.str.ToUpperCase(_Sexuality)='BISEXUAL' =>
                                IF(left.Sexuality_Bisexual=0,-200,left.Sexuality_Bisexual),0);

        self.GenderIdentity := map(std.str.ToUpperCase(_GenderIdentity)='MALE' =>
                                IF(left.Gender_Male=0,-200,left.Gender_Male),
                                std.str.ToUpperCase(_GenderIdentity)='FEMALE' =>
                                IF(left.Gender_Female=0,-200,left.Gender_Female),
                                std.str.ToUpperCase(_GenderIdentity)='TRANSGENDER' =>
                                IF(left.Gender_Transgender=0,-200,left.Gender_Transgender),
                                std.str.ToUpperCase(_GenderIdentity)='NONBINARY' =>
                                IF(left.Gender_Non_binary=0,-200,left.Gender_Non_binary),0);

        //to calculate total score of the mentor, individual scores of each fields are added

        SELF.TotScore :=  SELF.Religion +   SELF.roleoffaith+SELF.FavoritePlace+ SELF.Personality +SELF.SocialStyle + SELF.AlcoholUse +SELF.Smoking
                            + Self.JobRetentionChallenges + SELF.DayOff +self.SadnessResponse +self.AngerResponse  +self.ContinuingEducation
                            +  self.SupportNeeds+  self.CriminalHistory + self.Children + self.BioRelationships +self.Sexuality +self.GenderIdentity;
        
        self.HumanReview := hum_ver; 
        self.distance_From_Youth:=   left.distance;

        )
        );

//sorting mentors based on decreasing order of total score to display the best mentors first
Best_Mentors := SORT(projMentorT4,-TotScore,distance_From_Youth);

//eliminating all the mentors who had a particular field equal to 0 and child was active in that field
OUTPUT(Best_Mentors(TotScore > 0),named('Best_Mentors'));
