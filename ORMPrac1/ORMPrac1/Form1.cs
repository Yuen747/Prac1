﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ORMPrac1
{
    public partial class Form1 : Form
    {
        public List<Model.ALUMNO> oAlumno;
        public List<Model.APODERADO> oApoderado;
        public List<Model.CURSO> oCurso;
        public List<Model.INSCRITO> oInscrito;
        int indice = 0;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //Agregamos las opciones disponibles que saldrán en la lista 1.
            comboBox1.Items.Add("Alumno");
            comboBox1.Items.Add("Apoderado");
            comboBox1.Items.Add("Curso");
            comboBox1.Items.Add("Inscrito");




        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
            {
                switch (comboBox1.SelectedIndex)
                {
                    //Busca los datos y enlistarlso.
                    case 0:
                        oAlumno = db.ALUMNO.ToList();
                        break;

                    case 1:
                        oApoderado = db.APODERADO.ToList();
                        break;

                    case 2:
                        oCurso = db.CURSO.ToList();
                        break;

                    case 3:
                        oInscrito = db.INSCRITO.ToList();
                        break;



                }
            }
            indice = 0;
            Llenar();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Ir al dato anterior.
            indice--;
            Llenar();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            //Ir al dato siguiente.
            indice++;
            Llenar();
        }
        public void Llenar()
        {
            if (indice < 0)
                indice = 0;
            string cadena = "";
            switch (comboBox1.SelectedIndex)
            {

                case 0:
                    if (indice >= oAlumno.Count)
                        indice = oAlumno.Count - 1;
                    cadena = oAlumno[indice].Id.ToString() + ". " + oAlumno[indice].Nombre + ", de " + oAlumno[indice].Ciudad + ", " + oAlumno[indice].Edad + " años";
                    break;

                case 1:
                    if (indice >= oApoderado.Count)
                        indice = oApoderado.Count - 1;
                    using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
                    {
                        oAlumno = db.ALUMNO.ToList();
                        cadena = oApoderado[indice].Id.ToString() + ". " + oApoderado[indice].Nombre + ", es el|la apoderado|a de " + oAlumno.Find(a => a.Id == (int)oApoderado[indice].Id_Alumno).Nombre;

                    }

                    break;
                case 2:
                    if (indice >= oCurso.Count)
                        indice = oCurso.Count - 1;
                    using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
                    {

                        cadena = oCurso[indice].Cod.ToString() + ". " + oCurso[indice].Nombre + ", es el curso de " + oCurso.Find(a => a.Cod == (int)oCurso[indice].Cod).Nombre;
                    }
                    break;

                case 3:
                    if (indice >= oInscrito.Count)
                        indice = oInscrito.Count - 1;
                    using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
                    {
                        oCurso = db.CURSO.ToList();
                        oAlumno = db.ALUMNO.ToList();
                        cadena = oInscrito[indice].Id.ToString() + ". " + oInscrito[indice].Cod_Curso + ", es el inscrito de " + oInscrito.Find(a => a.Id == (int)oInscrito[indice].Id_Alumno).Cod_Curso;



                    }
                    break;
            }
                    textBox1.Text = cadena;
            }
        }
    }
