using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Calender
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<Event> GetEvents()
        {
            string constr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;

            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter da = new SqlDataAdapter("Select * from Events", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            List<Event> eventsList = dt.AsEnumerable().Select(row => new Event
            {
                // assuming column 0's type is Nullable<long>
                CId = row.Field<int>(0),
                EventName = row.Field<string>(1),
                EventDiscription = row.Field<string>(2),
                StartDate = row.Field<string>(3),
                ToDate = row.Field<string>(4),

            }).ToList();

            return eventsList;
        }

        public class Event
        {
            public int CId { get; set; }
            public string EventName { get; set; }
            public string EventDiscription { get; set; }
            public string StartDate { get; set; }
            public string ToDate { get; set; }

        }
    }
}