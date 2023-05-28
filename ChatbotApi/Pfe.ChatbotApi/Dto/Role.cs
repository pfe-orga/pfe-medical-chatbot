namespace Pfe.ChatbotApi.Core
{
    public static class Role
    {
        public const string Doctor = "doctor";
        public const string Admin = "admin";
        public const string Patient = "patient";



        public static IEnumerable<string> AllRoles()
        {
            yield return Doctor;
            yield return Admin;
            yield return Patient;
        }
    }



}
