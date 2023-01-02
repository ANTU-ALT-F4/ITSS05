using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ITSS05
{
    class ChuoiKetNoi
    {
        public static string sqlcon = @"Data Source=FIT;Initial Catalog=ITSS05;User ID=sa;Password=123456";
        private static SqlConnection cn;

        public void Open()
        {
            cn.Open();
        }

        public void Close()
        {
            cn.Close();
        }

        public static SqlDataAdapter ad;
        public static DataTable dt; //Dùng để show dữ liệu ra dgv
        public static SqlCommandBuilder bd;
        public static SqlCommand cmd;

        public static void HienThi(String chuoi, DataGridView db1)
        {
            ad = new SqlDataAdapter(chuoi, sqlcon);
            dt = new DataTable();
            bd = new SqlCommandBuilder(ad);
            ad.Fill(dt);
            db1.DataSource = dt;
        }

        // hàm xử lý combobox
        public static void xulycbx(string chuoi, ComboBox cbx)
        {
            try
            {
                ad = new SqlDataAdapter(chuoi, sqlcon);
                dt = new DataTable();

                ad.Fill(dt);
                cbx.DataSource = dt;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Có lỗi" + ex);
            }
        }

        public static void TTCSDL(string sql, SqlDataAdapter adx, SqlCommand cmdx, DataSet dsx) //dsx tự cho ví dụ bạn thêm vào các chuỗi truy vấn khác nhau thì để dsx thành ds1,ds2,ds3
        {
            cn = new SqlConnection(sqlcon);
            cn.Open();
            cmdx = new SqlCommand(sql, cn);
            adx = new SqlDataAdapter(cmdx);
            dsx = new DataSet();
            adx.Fill(dsx);
            cn.Close();
        }


        public static void delete(string sql)
        {
            if (MessageBox.Show("Bạn có chắc chăn muốn xóa không ? ", "Thông báo ", MessageBoxButtons.OKCancel) == DialogResult.OK)
            {
                try
                {
                    cn = new SqlConnection(sqlcon);
                    cn.Open();
                    cmd = new SqlCommand(sql, cn);
                    cmd.ExecuteNonQuery();
                    cn.Close();
                    MessageBox.Show("Bạn đã xóa thành công ! ", "Thông báo", MessageBoxButtons.OK);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("" + ex);
                }
            }
        }
    }
}
