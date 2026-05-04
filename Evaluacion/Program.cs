using System;
using System.Windows.Forms;

namespace Evaluacion
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());  // ← Asegúrate que Form1 existe
        }
    }
}