import std;
EXPORT extras := MODULE

    
    EXPORT MentorsRaw_Rec := RECORD
        STRING       FullName;
        STRING       FirstName;
        STRING       LastName;
        STRING       Gender;
        STRING       Status;
        STRING       Region;
        STRING       Ethnicity;
        STRING       Occupation_primary;
        STRING       MaritalStatus;
        STRING       Spouse_FirstName;
        STRING       Spouse_LastName;
        STRING       Spouse_Gender;
        STRING       Spouse_RaceEthnicity;
        STRING       Spouse_Birthday;
        STRING       Spouse_Age;
        STRING       Spouse_Occupation;
        STRING       Street;
        STRING       City;
        STRING       State;
        STRING       ZipCode;
        INTEGER1     Religion_Christian;
        INTEGER1     Religion_Muslim;
        INTEGER1     Religion_Jewish;
        INTEGER1     Religion_Hindu;
        INTEGER1     Religion_Buddhist;
        INTEGER1     Religion_Other;
        INTEGER1     Religion_Spiritual;
        INTEGER1     Religion_None;
        STRING       RoleofFaith_primary;
        STRING       RoleofFaith_spouse;
        INTEGER1     Alcohol_Occasional;
        INTEGER1     Alcohol_Responsible;
        INTEGER1     Alcohol_Irresponsible;
        INTEGER1     DrugUse;
        INTEGER1     Marijuana_Occasional;
        INTEGER1     Marijuana_Regular;
        INTEGER1     Cigarettes_Occasional;
        INTEGER1     Cigarettes_Regular;
        INTEGER1     Vaping_Occasional;
        INTEGER1     Vaping_Regular;
        INTEGER1     JobRetentionChallenges;
        STRING       DayOff_primary;
        STRING       DayOff_spouse;
        STRING       FavoritPlace_primary;
        STRING       FavoritePlace_spouse;
        STRING       Personality_primary;
        STRING       Personality_spouse;
        INTEGER1     SocialStyle_Introverted;
        INTEGER1     SocialStyle_Extraverted;
        INTEGER1     SocialStyle_Both;
        STRING       SadnessResponse_primary;
        STRING       SadnessResponse_spouse;
        STRING       AngerResponse_primary;
        STRING       AngerResponse_spouse;
        INTEGER1     ContinuingEducation;
        INTEGER1     Supports_Holidays;
        INTEGER1     Supports_Job;
        INTEGER1     Supports_Parenting;
        INTEGER1     Supports_Medical;
        INTEGER1     Supports_Legal;
        INTEGER1     Supports_Budgeting;
        INTEGER1     Supports_MentalHealth;
        INTEGER1     Supports_Resources;
        INTEGER1     Supports_Social;
        STRING       Multiple_Matches;
        STRING       Match_Housing;
        STRING       Emergency_Housing;
        INTEGER1     CriminalHistory_Arrested;
        INTEGER1     CriminalHistory_Jail;
        INTEGER1     CriminalHistory_CurrentProbation;
        INTEGER1     Children_Pregnant;
        INTEGER1     Children_Custody1;
        INTEGER1     Children_Custodymultiple;
        INTEGER1     Children_Kincare1;
        INTEGER1     Children_Kincaremultiple;
        INTEGER1     Children_Welfare1;
        INTEGER1     Children_Welfaremultiple;
        INTEGER1     Bio_Important;
        INTEGER1     Bio_Difficult;
        INTEGER1     Sexuality_Heterosexual;
        INTEGER1     Sexuality_Homosexual;
        INTEGER1     Sexuality_Bisexual;
        INTEGER1     Gender_Male;
        INTEGER1     Gender_Female;
        INTEGER1     Gender_Transgender;
        INTEGER1     Gender_Non_binary;
        REAL4        Latitude;
        REAL4        Logatitude;

    END;

    EXPORT Mentor   := DATASET('~raw::connectionshomes::mentoringfamilies::thor', MentorsRaw_Rec, THOR);

    //record structure for cleaned mentor data
   EXPORT MentorsT1 := RECORD
        string FullName:= std.Str.toUpperCase(Mentor.FullName);
        mentor.Religion_Christian;
        mentor.Religion_Muslim;
        mentor.Religion_Jewish;
        mentor.Religion_Hindu;
        mentor.Religion_Buddhist;
        mentor.Religion_Other;
        mentor.Religion_Spiritual;
        mentor.Religion_None;
        string RoleofFaith_primary:= std.Str.toUpperCase(mentor.RoleofFaith_primary);
        string RoleofFaith_spouse:= std.Str.toUpperCase(mentor.RoleofFaith_spouse);
        mentor.Alcohol_Occasional;
        mentor.Alcohol_Responsible;
        mentor.Alcohol_Irresponsible;
        mentor.DrugUse;
        mentor.Marijuana_Occasional;
        mentor.Marijuana_Regular;
        mentor.Cigarettes_Occasional;
        mentor.Cigarettes_Regular;
        mentor.Vaping_Occasional;
        mentor.Vaping_Regular;
        mentor.JobRetentionChallenges;
        string DayOff_primary:= std.Str.toUpperCase(mentor.DayOff_primary);
        string DayOff_spouse:= std.Str.toUpperCase(mentor.DayOff_spouse);
        string FavoritPlace_primary:= std.Str.toUpperCase(mentor.FavoritPlace_primary);
        string FavoritePlace_spouse:= std.Str.toUpperCase(mentor.FavoritePlace_spouse);
        string Personality_primary:= std.Str.toUpperCase(mentor.Personality_primary);
        string Personality_spouse:= std.Str.toUpperCase(mentor.Personality_spouse);
        mentor.SocialStyle_Introverted;
        mentor.SocialStyle_Extraverted;
        mentor.SocialStyle_Both;
        string SadnessResponse_primary:= std.Str.toUpperCase(mentor.SadnessResponse_primary);
        string SadnessResponse_spouse:= std.Str.toUpperCase(mentor.SadnessResponse_spouse);
        string AngerResponse_primary:= std.Str.toUpperCase(mentor.AngerResponse_primary);
        string AngerResponse_spouse:= std.Str.toUpperCase(mentor.AngerResponse_spouse);
        mentor.ContinuingEducation;
        mentor.Supports_Holidays;
        mentor.Supports_Job;
        mentor.Supports_Parenting;
        mentor.Supports_Medical;
        mentor.Supports_Legal;
        mentor.Supports_Budgeting;
        mentor.Supports_MentalHealth;
        mentor.Supports_Resources;
        mentor.Supports_Social;
        string Multiple_Matches:= std.Str.toUpperCase(mentor.Multiple_Matches);
        string Match_Housing:= std.Str.toUpperCase(mentor.Match_Housing);
        string Emergency_Housing:= std.Str.toUpperCase(mentor.Emergency_Housing);
        mentor.CriminalHistory_Arrested;
        mentor.CriminalHistory_Jail;
        mentor.CriminalHistory_CurrentProbation;
        mentor.Children_Pregnant;
        mentor.Children_Custody1;
        mentor.Children_Custodymultiple;
        mentor.Children_Kincare1;
        mentor.Children_Kincaremultiple;
        mentor.Children_Welfare1;
        mentor.Children_Welfaremultiple;
        mentor.Bio_Important;
        mentor.Bio_Difficult;
        mentor.Sexuality_Heterosexual;
        mentor.Sexuality_Homosexual;
        mentor.Sexuality_Bisexual;
        mentor.Gender_Male;
        mentor.Gender_Female;
        mentor.Gender_Transgender;
        mentor.Gender_Non_binary;
        mentor.Latitude;
        mentor.Logatitude;
        real4 distance:=0;
   END;

   EXPORT projMentorT1 :=table(Mentor,MentorsT1);

// record structure of the input query
    EXPORT SampleRec := RECORD
        STRING    FirstName;
        STRING    LastName;
        STRING    ZipCode;
        STRING    Region;
        STRING    Race_Ethnicity; 
        STRING    Religion;
        STRING    RoleofFaith;
        STRING    AlcoholUse;
        STRING    marijuana;
        STRING    cigarettes;
        STRING    vape;
        STRING    JobRetentionChallenges;
        STRING    DayOff;
        STRING    FavoritePlace;
        STRING    Personality;
        STRING    SocialStyle;
        STRING    SadnessResponse;
        STRING    AngerResponse;
        STRING    ContinuingEducation; 
        STRING    SupportNeeds;
        STRING    CriminalHistory;
        STRING    Children;
        STRING    BioRelationships;
        STRING    Sexuality;
        STRING    GenderIdentity;
        REAL4     Latitude;
        REAl4     Longitude;
        REAL4  Distance;
    END;

    //function to calculate distance from latitude and longitude
    export REAL4 Distance (REAL4 Lat1, REAL4 Long1, REAL4 Lat2, REAL4 Long2) := FUNCTION
    

        REAL4 p := 22 / 7;
        REAL4 rad := p / 180;

        Latitude1 := Lat1 * rad;
        Longitude1 := Long1 * rad;
        Latitude2 := Lat2 * rad;
        Longitude2 := Long2 * rad;

        Long_Diff := Longitude2 - Longitude1;
        Lat_Diff := Latitude2 - Latitude1;

        x := POWER(SIN(Lat_Diff / 2), 2) + COS(Latitude1) * COS(Latitude2)* POWER(SIN(Long_Diff / 2), 2);

        ans := 2 * 3956 * ASIN(SQRT(x));

        RETURN ans;
    END;

//record structure for output
    export outLayout := RECORD 
        STRING      FullName;
        REAL    TotScore;
        STRING HumanReview;
        real distance_From_Youth;
        REAL    Religion:=0;
        REAL    RoleofFaith;
        REAL    AlcoholUse;
        REAL    Smoking;
        REAL    JobRetentionChallenges;
        REAL    DayOff;
        REAL    FavoritePlace;
        REAL    Personality;
        REAL    SocialStyle;
        REAL    SadnessResponse;
        REAL    AngerResponse;
        REAL    ContinuingEducation; 
        REAL    SupportNeeds;
        REAL    CriminalHistory;
        REAL    Children;
        REAL    BioRelationships;
        REAL    Sexuality;
        REAL    GenderIdentity;
        
    END;


      
END;