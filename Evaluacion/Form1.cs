using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Evaluacion  // ← IMPORTANTE: debe coincidir con tu Program.cs
{
    public partial class Form1 : Form  // ← Si tu programa usa Form1
    {
        public Form1()
        {
            InitializeComponent();
        }

        private string GetConnectionString()
        {
            return "Data Source=.;Initial Catalog=SeguimientoCargaAnchaDB;Integrated Security=True;";
        }

        private void CargarDatos(string query)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    dvg1.DataSource = dt;  // ← Tu DataGridView se llama dvg1
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message, "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btn1_Click(object sender, EventArgs e)
        {
            CargarDatos("SELECT id_conductor, nombre, apellido, licencia, telefono FROM conductor");
        }

        private void btn2_Click(object sender, EventArgs e)
        {
            CargarDatos("SELECT id_empresa, razon_social, ruc, direccion, telefono FROM empresa");
        }

        private void btn3_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT v.id_vehiculo, e.razon_social AS empresa, v.placa, v.marca, v.modelo, v.anio, v.capacidad_toneladas 
                         FROM vehiculo v INNER JOIN empresa e ON v.id_empresa = e.id_empresa");
        }

        private void btn4_Click(object sender, EventArgs e)
        {
            CargarDatos("SELECT id_ruta, origen, destino, distancia_km FROM ruta");
        }

        private void btn5_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT m.id_monitoreo, v.placa, c.nombre + ' ' + c.apellido AS conductor, r.origen, r.destino, m.fecha_salida, m.fecha_llegada, m.estado
                         FROM monitoreo m
                         INNER JOIN vehiculo v ON m.id_vehiculo = v.id_vehiculo
                         INNER JOIN conductor c ON m.id_conductor = c.id_conductor
                         INNER JOIN ruta r ON m.id_ruta = r.id_ruta");
        }

        private void btn6_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT c.id_consumo, v.placa, c.cantidad_litros, c.costo_total, c.fecha_registro
                         FROM consumo_combustible c
                         INNER JOIN monitoreo m ON c.id_monitoreo = m.id_monitoreo
                         INNER JOIN vehiculo v ON m.id_vehiculo = v.id_vehiculo");
        }

        private void btn7_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT i.id_incidencia, v.placa, c.nombre + ' ' + c.apellido AS conductor, i.tipo, i.descripcion, i.fecha
                         FROM incidencia i
                         INNER JOIN monitoreo m ON i.id_monitoreo = m.id_monitoreo
                         INNER JOIN vehiculo v ON m.id_vehiculo = v.id_vehiculo
                         INNER JOIN conductor c ON m.id_conductor = c.id_conductor");
        }

        private void btn8_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT m.id_mantenimiento, v.placa, m.descripcion, m.fecha, m.costo
                         FROM mantenimiento m INNER JOIN vehiculo v ON m.id_vehiculo = v.id_vehiculo");
        }

        private void btn9_Click(object sender, EventArgs e)
        {
            CargarDatos("SELECT id_proveedor, nombre, ruc, telefono, direccion FROM proveedor");
        }

        private void btn10_Click(object sender, EventArgs e)
        {
            CargarDatos(@"SELECT r.id_repuesto, p.nombre AS proveedor, r.nombre AS repuesto, r.precio, r.stock
                         FROM repuesto r INNER JOIN proveedor p ON r.id_proveedor = p.id_proveedor");
        }
    }
}