namespace Pfe.ChatbotApi.Core
{
    public static class Roles
    {
        public const string Doctor = "Doctor";
        public const string Admin = "Admin";
        public const string Patient = "Patient";

        public static IEnumerable<string> AllRoles()
        {
            yield return Doctor;
            yield return Admin;
            yield return Patient;
        }
    }

}
