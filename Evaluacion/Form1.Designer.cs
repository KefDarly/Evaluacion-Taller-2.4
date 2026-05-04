namespace Evaluacion  // 🔥 CORREGIDO
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.btn1 = new System.Windows.Forms.Button();
            this.btn2 = new System.Windows.Forms.Button();
            this.btn3 = new System.Windows.Forms.Button();
            this.btn4 = new System.Windows.Forms.Button();
            this.btn5 = new System.Windows.Forms.Button();
            this.btn6 = new System.Windows.Forms.Button();
            this.btn7 = new System.Windows.Forms.Button();
            this.btn8 = new System.Windows.Forms.Button();
            this.btn9 = new System.Windows.Forms.Button();
            this.btn10 = new System.Windows.Forms.Button();
            this.dvg1 = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dvg1)).BeginInit();
            this.SuspendLayout();

            // BOTONES
            this.btn1.Location = new System.Drawing.Point(26, 29);
            this.btn1.Name = "btn1";
            this.btn1.Size = new System.Drawing.Size(75, 23);
            this.btn1.Text = "Conductores";
            this.btn1.Click += new System.EventHandler(this.btn1_Click);

            this.btn2.Location = new System.Drawing.Point(160, 29);
            this.btn2.Name = "btn2";
            this.btn2.Size = new System.Drawing.Size(75, 23);
            this.btn2.Text = "Empresas";
            this.btn2.Click += new System.EventHandler(this.btn2_Click);

            this.btn3.Location = new System.Drawing.Point(303, 29);
            this.btn3.Name = "btn3";
            this.btn3.Size = new System.Drawing.Size(75, 23);
            this.btn3.Text = "Vehículos";
            this.btn3.Click += new System.EventHandler(this.btn3_Click);

            this.btn4.Location = new System.Drawing.Point(447, 29);
            this.btn4.Name = "btn4";
            this.btn4.Size = new System.Drawing.Size(75, 23);
            this.btn4.Text = "Rutas";
            this.btn4.Click += new System.EventHandler(this.btn4_Click);

            this.btn5.Location = new System.Drawing.Point(602, 29);
            this.btn5.Name = "btn5";
            this.btn5.Size = new System.Drawing.Size(75, 23);
            this.btn5.Text = "Monitoreo";
            this.btn5.Click += new System.EventHandler(this.btn5_Click);

            this.btn6.Location = new System.Drawing.Point(26, 85);
            this.btn6.Name = "btn6";
            this.btn6.Size = new System.Drawing.Size(75, 23);
            this.btn6.Text = "Combustible";
            this.btn6.Click += new System.EventHandler(this.btn6_Click);

            this.btn7.Location = new System.Drawing.Point(160, 85);
            this.btn7.Name = "btn7";
            this.btn7.Size = new System.Drawing.Size(75, 23);
            this.btn7.Text = "Incidencias";
            this.btn7.Click += new System.EventHandler(this.btn7_Click); // 🔥 CORREGIDO

            this.btn8.Location = new System.Drawing.Point(303, 85);
            this.btn8.Name = "btn8";
            this.btn8.Size = new System.Drawing.Size(75, 23);
            this.btn8.Text = "Mantenimiento";
            this.btn8.Click += new System.EventHandler(this.btn8_Click);

            this.btn9.Location = new System.Drawing.Point(447, 85);
            this.btn9.Name = "btn9";
            this.btn9.Size = new System.Drawing.Size(75, 23);
            this.btn9.Text = "Proveedor";
            this.btn9.Click += new System.EventHandler(this.btn9_Click);

            this.btn10.Location = new System.Drawing.Point(602, 85);
            this.btn10.Name = "btn10";
            this.btn10.Size = new System.Drawing.Size(75, 23);
            this.btn10.Text = "Repuestos";
            this.btn10.Click += new System.EventHandler(this.btn10_Click);

            // GRID
            this.dvg1.Location = new System.Drawing.Point(26, 139);
            this.dvg1.Size = new System.Drawing.Size(651, 287);

            // FORM
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.dvg1);
            this.Controls.Add(this.btn10);
            this.Controls.Add(this.btn9);
            this.Controls.Add(this.btn8);
            this.Controls.Add(this.btn7);
            this.Controls.Add(this.btn6);
            this.Controls.Add(this.btn5);
            this.Controls.Add(this.btn4);
            this.Controls.Add(this.btn3);
            this.Controls.Add(this.btn2);
            this.Controls.Add(this.btn1);
            this.Text = "Sistema de Seguimiento";

            ((System.ComponentModel.ISupportInitialize)(this.dvg1)).EndInit();
            this.ResumeLayout(false);
        }

        private System.Windows.Forms.Button btn1;
        private System.Windows.Forms.Button btn2;
        private System.Windows.Forms.Button btn3;
        private System.Windows.Forms.Button btn4;
        private System.Windows.Forms.Button btn5;
        private System.Windows.Forms.Button btn6;
        private System.Windows.Forms.Button btn7;
        private System.Windows.Forms.Button btn8;
        private System.Windows.Forms.Button btn9;
        private System.Windows.Forms.Button btn10;
        private System.Windows.Forms.DataGridView dvg1;
    }
}