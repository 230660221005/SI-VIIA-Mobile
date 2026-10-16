import 'package:flutter/material.dart';

void main(){
 runApp(const MoneyTrack());
}

class MoneyTrack extends StatelessWidget{
 const MoneyTrack({super.key});

 @override
 Widget build(BuildContext context){
  return MaterialApp(
   debugShowCheckedModeBanner:false,
   initialRoute:'/login',
   routes:{
    '/login':(context)=>LoginPage(),
    '/home':(context)=>HomePage(),
    '/transaction':(context)=>TransactionPage(),
    '/detail':(context)=>DetailPage(),
    '/add':(context)=>AddTransactionPage(),
   },
  );
 }
}

class LoginPage extends StatelessWidget{
 @override
 Widget build(BuildContext context){
  return Scaffold(
   body:Center(
    child:ElevatedButton(
     child:Text("Login"),
     onPressed:()=>Navigator.pushNamed(context,'/home'),
    ),
   ),
  );
 }
}

class HomePage extends StatelessWidget{
 @override
 Widget build(BuildContext context){
  return Scaffold(
   appBar:AppBar(title:Text("MoneyTrack")),
   body:Center(
    child:ElevatedButton(
     child:Text("Lihat Transaksi"),
     onPressed:()=>Navigator.pushNamed(context,'/transaction'),
    ),
   ),
  );
 }
}

class TransactionPage extends StatelessWidget{
 final data={"nama":"Beli Buku","jumlah":"50000"};

 @override
 Widget build(BuildContext context){
  return Scaffold(
   appBar:AppBar(title:Text("Transaksi")),
   body:Column(
    children:[
     ListTile(
      title:Text(data["nama"]!),
      subtitle:Text(data["jumlah"]!),
      onTap:(){
       Navigator.pushNamed(context,'/detail',arguments:data);
      },
     ),
     ElevatedButton(
      child:Text("Tambah"),
      onPressed:()=>Navigator.pushNamed(context,'/add'),
     )
    ],
   ),
  );
 }
}

class DetailPage extends StatelessWidget{

 @override
 Widget build(BuildContext context){

  final args = ModalRoute.of(context)?.settings.arguments;


  if(args is Map<String,String>){

   return Scaffold(

    appBar: AppBar(
     title: Text("Detail Transaksi"),
    ),


    body: Center(

     child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children:[


       Text(
        "Nama: ${args["nama"]}",
        style: TextStyle(fontSize:20),
       ),


       Text(
        "Jumlah: Rp${args["jumlah"]}",
        style: TextStyle(fontSize:20),
       ),


       SizedBox(height:20),


       ElevatedButton(

        child: Text("Kembali"),


        onPressed: (){

         Navigator.pop(context);

        },

       )


      ],

     ),

    ),

   );


  }


  return Scaffold(

   body: Center(

    child: Text("Data transaksi tidak ditemukan"),

   ),

  );


 }

}

class AddTransactionPage extends StatefulWidget{
 @override
 State<AddTransactionPage> createState()=>_AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage>{
 final formKey=GlobalKey<FormState>();
 final namaController=TextEditingController();
 final jumlahController=TextEditingController();

 @override
 void dispose(){
  namaController.dispose();
  jumlahController.dispose();
  super.dispose();
 }

 void submit(){
  if(formKey.currentState!.validate()){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("Transaksi berhasil ditambahkan"))
   );
  }
 }

 @override
 Widget build(BuildContext context){
  return Scaffold(
   appBar:AppBar(title:Text("Tambah Transaksi")),
   body:Form(
    key:formKey,
    child:Column(
     children:[
      TextFormField(
       controller:namaController,
       validator:(v)=>v==null||v.isEmpty?"Nama wajib diisi":null,
      ),
      TextFormField(
       controller:jumlahController,
       validator:(v)=>v==null||v.isEmpty?"Jumlah wajib diisi":null,
      ),
      ElevatedButton(onPressed:submit,child:Text("Simpan"))
     ],
    ),
   ),
  );
 }
}
