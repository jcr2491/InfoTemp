using System;
using System.Windows.Forms;
using MetroFramework;
using MetroFramework.Forms;
using Sigcomt.Business.Logic;
using Sigcomt.Common;
using Sigcomt.WinForms.BulkCopy.Core;

namespace Sigcomt.WinForms.BulkCopy.Forms
{
    public partial class FrmLogin : MetroForm
    {
        public FrmLogin()
        {
            InitializeComponent();
            mtxtUsuario.Focus();
        }

        #region Eventos

        private void mbtnEntrar_Click(object sender, EventArgs e)
        {
            Ingresar();
        }

        private void mtxtClave_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Enter))
            {
                mbtnEntrar.PerformClick();
            }
        }

        private void mbtnCancelar_Click(object sender, EventArgs e)
        {
            Close();
        }

        #endregion

        #region Métodos

        private void Ingresar()
        {
            string nombreUser = mtxtUsuario.Text.Trim();
            string clave = mtxtClave.Text.Trim();
            string msg = string.Empty;

            if (nombreUser == string.Empty) msg = $"\n{Constantes.UsuarioRequerido}.";
            if (clave == string.Empty) msg += $"\n{Constantes.ClaveRequerida}.";

            if (msg != string.Empty)
            {
                MetroMessageBox.Show(this, msg, Constantes.Error, MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            var user = UsuarioBL.GetInstance().GetUsuario(nombreUser, Encriptador.Encriptar(clave));

            if (user != null)
            {
                Constantes.Usuario = user;

                Hide();
                FormCarga form = new FormCarga();
                form.Show();
            }
            else
            {
                MetroMessageBox.Show(this, $"\n{Constantes.CredencialesIncorrectas}", Constantes.Error,
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);

                mtxtClave.Text = string.Empty;
                mtxtClave.Focus();
            }
        }

        #endregion
    }
}