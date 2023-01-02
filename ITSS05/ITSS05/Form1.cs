using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace ITSS05
{
    public partial class Form1 : Form
    {
        SqlConnection cn;
        private static string chuoi = "SELECT locations.name,SUM(t1.UnitPrice) as t1, SUM(t2.UnitPrice) as t2,SUM(t3.UnitPrice) as t3,SUM(t4.UnitPrice) as t4 \r\nFROM departmentlocations\r\nINNER JOIN locations ON departmentlocations.locationid = locations.id\r\nINNER JOIN assets ON assets.departmentlocationid = departmentlocations.id\r\nINNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id\r\nINNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id\r\nINNER JOIN orderitems ON orderitems.orderid = orders.id\r\nLEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'\r\nLEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'\r\nLEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'\r\nLEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'\r\nGROUP BY locations.name\r\nORDER BY locations.name,SUM(t1.UnitPrice), SUM(t2.UnitPrice),SUM(t3.UnitPrice),SUM(t4.UnitPrice)";
        public Form1()
        {
            cn = new SqlConnection(ChuoiKetNoi.sqlcon);
            InitializeComponent();
        }

        string t2 = "";
        string t3 = "";
        string t4 = "";
        string t5 = "";

        public void loaddgv1()
        {
            #region /*Thêm 0 vào cell có giá trị null*/
            /*
            cn.Open();
            using (var cmd = new SqlCommand(chuoi, cn))
            {
                using (var render = cmd.ExecuteReader())
                {
                    while (render.Read())
                    {
                        var t1 = render[0].ToString();
                        
                        if(string.IsNullOrEmpty(render[1].ToString()))
                        {
                            t2 = "0";
                        }
                        else
                        {
                            t2 = render[1].ToString();
                        }

                        if (string.IsNullOrEmpty(render[2].ToString()))
                        {
                            t3 = "0";
                        }
                        else
                        {
                            t3 = render[2].ToString();
                        }

                        if (string.IsNullOrEmpty(render[3].ToString()))
                        {
                            t4 = "0";
                        }
                        else
                        {
                            t4 = render[3].ToString();
                        }

                        if (string.IsNullOrEmpty(render[4].ToString()))
                        {
                            t5 = "0";
                        }
                        else
                        {
                            t5 = render[4].ToString();
                        }

                        dgv_1.Rows.Add(t1, t2, t3, t4, t5);
                    }
                }
            }
            cn.Close();
            */
            #endregion 
            ChuoiKetNoi.HienThi(chuoi, dgv_1);
        }
        #region /*Tạo Biến*/
        string MAX1 = "";
        string MIN1 = "";

        string MAX2 = "";
        string MIN2 = "";

        string MAX3 = "";
        string MIN3 = "";

        string MAX4 = "";
        string MIN4 = "";
        #endregion 
        private void Form1_Load(object sender, EventArgs e)
        {
            loaddgv1();
            #region /*Lấy dữ liệu lớn bé nhất trong cột*/
            MAX1 = (from DataGridViewRow row in dgv_1.Rows
                               where row.Cells["Column2"].FormattedValue.ToString() != string.Empty
                               select Convert.ToInt32(row.Cells["Column2"].FormattedValue)).Max().ToString();
            //MessageBox.Show(MAX1);

            MIN1 = (from DataGridViewRow row in dgv_1.Rows
                               where row.Cells["Column2"].FormattedValue.ToString() != string.Empty
                               select Convert.ToInt32(row.Cells["Column2"].FormattedValue)).Min().ToString();
            //MessageBox.Show(MIN1);

            //-----------------------------------------------------------------------------------
            
            MAX2 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column3"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column3"].FormattedValue)).Max().ToString();

            MIN2 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column3"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column3"].FormattedValue)).Min().ToString();

            //-----------------------------------------------------------------------------------
            MAX3 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column4"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column4"].FormattedValue)).Max().ToString();

            MIN3 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column4"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column4"].FormattedValue)).Min().ToString();
            //-----------------------------------------------------------------------------------

            MAX4 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column5"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column5"].FormattedValue)).Max().ToString();

            MIN4 = (from DataGridViewRow row in dgv_1.Rows
                    where row.Cells["Column5"].FormattedValue.ToString() != string.Empty
                    select Convert.ToInt32(row.Cells["Column5"].FormattedValue)).Min().ToString();
            #endregion
            loaddgv2();
            loaddgv3();
            Loadchart1();
            Loadchart2();
        }
        private void Loadchart1()
        {
            chart1.Series["s1"].Points.Add(Convert.ToDouble(MAX1));
            chart1.Series["s1"].Points[0].Color = Color.Red;
            chart1.Series["s1"].Points[0].AxisLabel = "2019-08";
            chart1.Series["s1"].Points[0].LegendText = "2019-08";
            chart1.Series["s1"].Points[0].Label = MAX1;

            chart1.Series["s1"].Points.Add(Convert.ToDouble(MAX2));
            chart1.Series["s1"].Points[1].Color = Color.Gray;
            chart1.Series["s1"].Points[1].AxisLabel = "2019-07";
            chart1.Series["s1"].Points[1].LegendText = "2019-07";
            chart1.Series["s1"].Points[1].Label = MAX2;

            chart1.Series["s1"].Points.Add(Convert.ToDouble(MAX3));
            chart1.Series["s1"].Points[2].Color = Color.Green;
            chart1.Series["s1"].Points[2].AxisLabel = "2019-03";
            chart1.Series["s1"].Points[2].LegendText = "2019-03";
            chart1.Series["s1"].Points[2].Label = MAX3;

            chart1.Series["s1"].Points.Add(Convert.ToDouble(MAX4));
            chart1.Series["s1"].Points[3].Color = Color.Yellow;
            chart1.Series["s1"].Points[3].AxisLabel = "2018-12";
            chart1.Series["s1"].Points[3].LegendText = "2018-12";
            chart1.Series["s1"].Points[3].Label = MAX4;
        }
        private void Loadchart2()
        {
            chart2.Series["s1"].Points.Add(Convert.ToDouble(MAX1));
            chart2.Series["s1"].Points[0].Color = Color.Red;
            chart2.Series["s1"].Points[0].AxisLabel = "2019-08";
            chart2.Series["s1"].Points[0].LegendText = "2019-08";
            chart2.Series["s1"].Points[0].Label = MAX1;
                 
            chart2.Series["s1"].Points.Add(Convert.ToDouble(MAX2));
            chart2.Series["s1"].Points[1].Color = Color.Gray;
            chart2.Series["s1"].Points[1].AxisLabel = "2019-07";
            chart2.Series["s1"].Points[1].LegendText = "2019-07";
            chart2.Series["s1"].Points[1].Label = MAX2;

            chart2.Series["s1"].Points.Add(Convert.ToDouble(MAX3));
            chart2.Series["s1"].Points[2].Color = Color.Green;
            chart2.Series["s1"].Points[2].AxisLabel = "2019-03";
            chart2.Series["s1"].Points[2].LegendText = "2019-03";
            chart2.Series["s1"].Points[2].Label = MAX3;
                 
            chart2.Series["s1"].Points.Add(Convert.ToDouble(MAX4));
            chart2.Series["s1"].Points[3].Color = Color.Yellow;
            chart2.Series["s1"].Points[3].AxisLabel = "2018-12";
            chart2.Series["s1"].Points[3].LegendText = "2018-12";
            chart2.Series["s1"].Points[3].Label = MAX4;
        }

        private void loaddgv2()
        {
            string truyvan = "select TOP(1) CONCAT(n1.name ,', ' , n1.name) as t1,CONCAT(n2.name ,', ' , n2.name)as t2,CONCAT(n3.name ,', ' , n3.name) as t3,CONCAT(n4.name ,', ' , n4.name) as t4\r\nfrom departmentlocations\r\nINNER JOIN departments ON departments.id = departmentlocations.departmentid\r\nINNER JOIN assets ON assets.departmentlocationid = departments.id\r\nINNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id\r\nINNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id\r\nINNER JOIN orderitems ON orderitems.orderid = orders.id\r\nLEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'\r\nLEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'\r\nLEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'\r\nLEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'\r\nRIGHT JOIN parts as n1 ON t1.partid = n1.id\r\nRIGHT JOIN parts as n2 ON t2.partid = n2.id\r\nRIGHT JOIN parts as n3 ON t3.partid = n3.id\r\nRIGHT JOIN parts as n4 ON t4.partid = n4.id";

            cn.Open();
                using (var cmd = new SqlCommand(truyvan, cn))
                {
                    using (var render = cmd.ExecuteReader())
                    {
                        while (render.Read())
                        {
                            var t1 = render[0].ToString();
                            var t2 = render[1].ToString();
                            var t3 = render[2].ToString();
                            var t4 = render[3].ToString();
                            dgv_2.Rows.Add("Highest Cost", t1, t2, t3, t4);
                        }
                    }
                }
                cn.Close();

            cn.Open();
            using (var cmd = new SqlCommand(truyvan, cn))
            {
                using (var render = cmd.ExecuteReader())
                {
                    while (render.Read())
                    {
                        var t1 = render[0].ToString();
                        var t2 = render[1].ToString();
                        var t3 = render[2].ToString();
                        var t4 = render[3].ToString();
                        dgv_2.Rows.Add("Most Number", t1, t2, t3, t4);
                    }
                }
            }
            cn.Close();
        }

        private void loaddgv3()
        {
            string truyvan1 = "select TOP(1) CONCAT(n1.name ,', ' , n1.name) as t1,CONCAT(n2.name ,', ' , n2.name)as t2,CONCAT(n3.name ,', ' , n3.name) as t3,CONCAT(n4.name ,', ' , n4.name) as t4\r\nfrom departmentlocations\r\nINNER JOIN departments ON departments.id = departmentlocations.departmentid\r\nINNER JOIN assets ON assets.departmentlocationid = departments.id\r\nINNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id\r\nINNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id\r\nINNER JOIN orderitems ON orderitems.orderid = orders.id\r\nLEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'\r\nLEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'\r\nLEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'\r\nLEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'\r\nRIGHT JOIN parts as n1 ON t1.partid = n1.id\r\nRIGHT JOIN parts as n2 ON t2.partid = n2.id\r\nRIGHT JOIN parts as n3 ON t3.partid = n3.id\r\nRIGHT JOIN parts as n4 ON t4.partid = n4.id";
            string truyvan2 = "select TOP(1) CONCAT(n1.name ,', ' , n1.name) as t1,CONCAT(n2.name ,', ' , n2.name)as t2,CONCAT(n3.name ,', ' , n3.name) as t3,CONCAT(n4.name ,', ' , n4.name) as t4\r\nfrom departmentlocations\r\nINNER JOIN departments ON departments.id = departmentlocations.departmentid\r\nINNER JOIN assets ON assets.departmentlocationid = departments.id\r\nINNER JOIN emergencymaintenances ON emergencymaintenances.assetid = assets.id\r\nINNER JOIN orders ON orders.EmergencyMaintenancesID = emergencymaintenances.id\r\nINNER JOIN orderitems ON orderitems.orderid = orders.id\r\nLEFT JOIN orderitems as t1 ON YEAR(date) = '2019' AND MONTH(date) = '08'\r\nLEFT JOIN orderitems as t2 ON YEAR(date) = '2019' AND MONTH(date) = '07'\r\nLEFT JOIN orderitems as t3 ON YEAR(date) = '2019' AND MONTH(date) = '03'\r\nLEFT JOIN orderitems as t4 ON YEAR(date) = '2018' AND MONTH(date) = '12'\r\nRIGHT JOIN parts as n1 ON t1.partid = n1.id\r\nRIGHT JOIN parts as n2 ON t2.partid = n2.id\r\nRIGHT JOIN parts as n3 ON t3.partid = n3.id\r\nRIGHT JOIN parts as n4 ON t4.partid = n4.id";

            cn.Open();
            using (var cmd = new SqlCommand(truyvan1, cn))
            {
                using (var render = cmd.ExecuteReader())
                {
                    while (render.Read())
                    {
                        var t1 = render[0].ToString();
                        var t2 = render[1].ToString();
                        var t3 = render[2].ToString();
                        var t4 = render[3].ToString();
                        dgv_3.Rows.Add("Asset", t1, t2, t3, t4);
                    }
                }
            }
            cn.Close();

            cn.Open();
            using (var cmd = new SqlCommand(truyvan2, cn))
            {
                using (var render = cmd.ExecuteReader())
                {
                    while (render.Read())
                    {
                        var t1 = render[0].ToString();
                        var t2 = render[1].ToString();
                        var t3 = render[2].ToString();
                        var t4 = render[3].ToString();
                        dgv_3.Rows.Add("Department", t1, t2, t3, t4);
                    }
                }
            }
            cn.Close();
        }

        private void dgv_1_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (dgv_1.RowCount > 0)
            {
                for (int i = 0; i < dgv_1.RowCount - 1; i++)
                {
                    #region /*Tô màu cho max min*/
                    if (dgv_1.Rows[i].Cells["Column2"].Value.ToString() == MAX1)
                    {
                        dgv_1.Rows[i].Cells["Column2"].Style.ForeColor = Color.Red;
                    }
                    if (dgv_1.Rows[i].Cells["Column3"].Value.ToString() == MAX2)
                    {
                        dgv_1.Rows[i].Cells["Column3"].Style.ForeColor = Color.Red;
                    }
                    if (dgv_1.Rows[i].Cells["Column4"].Value.ToString() == MAX3)
                    {
                        dgv_1.Rows[i].Cells["Column4"].Style.ForeColor = Color.Red;
                    }
                    if (dgv_1.Rows[i].Cells["Column5"].Value.ToString() == MAX4)
                    {
                        dgv_1.Rows[i].Cells["Column5"].Style.ForeColor = Color.Red;
                    }

                    if (dgv_1.Rows[i].Cells["Column2"].Value.ToString() == MIN1)
                    {
                        dgv_1.Rows[i].Cells["Column2"].Style.ForeColor = Color.Green;
                    }
                    if (dgv_1.Rows[i].Cells["Column3"].Value.ToString() == MIN2)
                    {
                        dgv_1.Rows[i].Cells["Column3"].Style.ForeColor = Color.Green;
                    }
                    if (dgv_1.Rows[i].Cells["Column4"].Value.ToString() == MIN3)
                    {
                        dgv_1.Rows[i].Cells["Column4"].Style.ForeColor = Color.Green;
                    }
                    if (dgv_1.Rows[i].Cells["Column5"].Value.ToString() == MIN4)
                    {
                        dgv_1.Rows[i].Cells["Column5"].Style.ForeColor = Color.Green;
                    }
                    #endregion 
                }
            }

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbLanguge.SelectedIndex == 0)
            {
                if(MessageBox.Show("Bạn Chọn Ngôn ngữ chính của hệ thống là tiếng anh","Thông Báo",MessageBoxButtons.OKCancel,MessageBoxIcon.Information) == DialogResult.OK)
                {
                    Properties.Settings.Default.Language = "en-US";
                    //Lưu xác định đó lại
                    Properties.Settings.Default.Save();
                }
            }
            else if(cbbLanguge.SelectedIndex == 1)
            {
                if (MessageBox.Show("Bạn Chọn Ngôn ngữ chính của hệ thống là tiếng việt", "Thông Báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
                {
                    Properties.Settings.Default.Language = "vi-VN";
                    //Lưu xác định đó lại
                    Properties.Settings.Default.Save();
                }
            }
            else
            {

            }
        }
    }
}
