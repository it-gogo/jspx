package com.go.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.security.Key;
import java.security.Security;

import javax.crypto.Cipher;

public class DESPlus {
	 private static String strDefaultKey = "national";

	 private Cipher encryptCipher = null;

	 private Cipher decryptCipher = null;

	 /**
	  * 将byte数组转换为表示16进制值的字符串， 如：byte[]{8,18}转换为：0813， 和public static byte[]
	  * hexStr2ByteArr(String strIn) 互为可逆的转换过程
	  * 
	  * @param arrB
	  *            需要转换的byte数组
	  * @return 转换后的字符串
	  * @throws Exception
	  *             本方法不处理任何异常，所有异常全部抛出
	  */
	 public static String byteArr2HexStr(byte[] arrB) throws Exception {
	  int iLen = arrB.length;
	  // 每个byte用两个字符才能表示，所以字符串的长度是数组长度的两倍
	  StringBuffer sb = new StringBuffer(iLen * 2);
	  for (int i = 0; i < iLen; i++) {
	   int intTmp = arrB[i];
	   // 把负数转换为正数
	   while (intTmp < 0) {
	    intTmp = intTmp + 256;
	   }
	   // 小于0F的数需要在前面补0
	   if (intTmp < 16) {
	    sb.append("0");
	   }
	   sb.append(Integer.toString(intTmp, 16));
	  }
	  return sb.toString();
	 }

	 /**
	  * 将表示16进制值的字符串转换为byte数组， 和public static String byteArr2HexStr(byte[] arrB)
	  * 互为可逆的转换过程
	  * 
	  * @param strIn
	  *            需要转换的字符串
	  * @return 转换后的byte数组
	  * @throws Exception
	  *             本方法不处理任何异常，所有异常全部抛出
	  * @author <a href="mailto:leo841001@163.com">LiGuoQing</a>
	  */
	 public static byte[] hexStr2ByteArr(String strIn) throws Exception {
	  byte[] arrB = strIn.getBytes();
	  int iLen = arrB.length;

	  // 两个字符表示一个字节，所以字节数组长度是字符串长度除以2
	  byte[] arrOut = new byte[iLen / 2];
	  for (int i = 0; i < iLen; i = i + 2) {
	   String strTmp = new String(arrB, i, 2);
	   arrOut[i / 2] = (byte) Integer.parseInt(strTmp, 16);
	  }
	  return arrOut;
	 }

	 /**
	  * 默认构造方法，使用默认密钥
	  * 
	  * @throws Exception
	  */
	 public DESPlus() throws Exception {
	  this(strDefaultKey);
	 }

	 /**
	  * 指定密钥构造方法
	  * 
	  * @param strKey
	  *            指定的密钥
	  * @throws Exception
	  */
	 public DESPlus(String strKey) throws Exception {
	  Security.addProvider(new com.sun.crypto.provider.SunJCE());
	  Key key = getKey(strKey.getBytes());

	  encryptCipher = Cipher.getInstance("DES");
	  encryptCipher.init(Cipher.ENCRYPT_MODE, key);

	  decryptCipher = Cipher.getInstance("DES");
	  decryptCipher.init(Cipher.DECRYPT_MODE, key);
	 }

	 /**
	  * 加密字节数组
	  * 
	  * @param arrB
	  *            需加密的字节数组
	  * @return 加密后的字节数组
	  * @throws Exception
	  */
	 public byte[] encrypt(byte[] arrB) throws Exception {
	  return encryptCipher.doFinal(arrB);
	 }

	 /**
	  * 加密字符串
	  * 
	  * @param strIn
	  *            需加密的字符串
	  * @return 加密后的字符串
	  * @throws Exception
	  */
	 public String encrypt(String strIn) throws Exception {
	  return byteArr2HexStr(encrypt(strIn.getBytes()));
	 }

	 /**
	  * 解密字节数组
	  * 
	  * @param arrB
	  *            需解密的字节数组
	  * @return 解密后的字节数组
	  * @throws Exception
	  */
	 public byte[] decrypt(byte[] arrB) throws Exception {
	  return decryptCipher.doFinal(arrB);
	 }

	 /**
	  * 解密字符串
	  * 
	  * @param strIn
	  *            需解密的字符串
	  * @return 解密后的字符串
	  * @throws Exception
	  */
	 public String decrypt(String strIn) throws Exception {
	  return new String(decrypt(hexStr2ByteArr(strIn)));
	 }

	 /**
	  * 从指定字符串生成密钥，密钥所需的字节数组长度为8位 不足8位时后面补0，超出8位只取前8位
	  * 
	  * @param arrBTmp
	  *            构成该字符串的字节数组
	  * @return 生成的密钥
	  * @throws java.lang.Exception
	  */
	 private Key getKey(byte[] arrBTmp) throws Exception {
	  // 创建一个空的8位字节数组（默认值为0）
	  byte[] arrB = new byte[8];

	  // 将原始字节数组转换为8位
	  for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
	   arrB[i] = arrBTmp[i];
	  }

	  // 生成密钥
	  Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");

	  return key;
	 }
	 
	 public static void main(String[] args) {
		  // TODO Auto-generated method stub
		  try {
		   String test = "";
		   //DESPlus des = new DESPlus();//默认密钥
		   DESPlus des = new DESPlus();//自定义密钥
		   System.out.println("加密前的字符："+test);
		   System.out.println("加密后的字符："+des.encrypt(test));
		   System.out.println("解密后的字符："+des.decrypt("dd00a6c390f23ff0871d6834143566e18b3e26eb831f9af4734a90028cce85dc9972f901536fb3b97b08ea8a56a21a674f20dbfe3fd99beef7bcb10225f42a7d591c1fbab2ad533f4e4483c32c2f91c5c7ee5228893654988d928d9f504fcc95a636d865c4df82c9430cb4f0b5da1e7549c2b2fb7dd092aa5f0c1dbf5ac9555cf62e7b1c8f003a2f0be2cd30fc04f837871d6834143566e18b3e26eb831f9af4734a90028cce85dc83f49395afc75ae0a2196669749988193838cd5e140f1664e13f998906534747a758b3a8ebe12c2259b617f8c98dac03c198dd382dd53c6b60407c2c6ff79ce389c44d43d4073c41af7c6cd36ea45fcf919c8408fead0491d97662b9ecfba371854ff51ddf8ff549171a9c35a694480bfbfc63158e6c43d978909a1914f21395a7b945b4c6b560a3f18c7d8c73dc548e87f90873b199d518a414e2cefbdf768be34094f23dcd1cc36cb9e42cf70d5ac09a27b8bb63ecaf0e259de90e9d4099aba119e63095405586185ec96784dda8c869cf5a93235b536bc591d3d7e40d2c427d7339b51b150c616689dd53d3c4a571db00836acb4d2f25be8b297f244436501d2e5cc665ced8428decfa91fcbfddf1b27fb2a07359c586e3baf629af23743bc8ebaa2b244167c95f240fff360edd913797a4d3c746b426b9416e0e9251850e8fb5e92b1fa9feeb555f55f5a9cf949e7b9fb6bb480697e28a5a34dd6797f8ab7e5696b89a0fbaacfe8d8d46817dd2984d36a1819117ad16c32c5eab3d217cde70a00687bee0a91b4ed8fc2fe00164571ee1e10e44181eeb70868651af79ecedd8febd4ffeb8060beec1b3d27fe414997915a1bd3d72eeef721bb20e2995f0de54b7e252678bd29c04fadaea259b2edc68a7836f5304faf6e36f9d806ef1aa9dcc124b98b1c06b59e0faaf21ef965bcc3adb7b83e0f85efe3c2c8c1bee107dcde14279f3cfb61d400dcdc4ea7dffd4ae9463cc2191a468f5c5cbfc3f21078329f61172b2106e56f84ac7f75f4c6f983fee8353735ff1229ffa4fd64687357208b66cf28a3c86078fe1748895a5b8a25d0d5faabb06499a8b3bfc97b6433d8d99400c797a058624b6ef9cbce2b8bd052e98355e4054a795732f3c64773ffa4f7ac3bd9b7241b64d136ded1c8758af8c0f3948d5e347f7a9da4577c3b8dfdd4599695a03f367d19fbfdc658c9616eeaaa36a86f19653f6b14e0720c356a257f5937fc9cd7360cd60297dff6fa8c01f3d9193c9885c09e79ba505465e99f41829890ba0da2c9a846b7561f636556fc68b1d9b21d3c213a94027429b4978015b6054f406246f222d6618f4872e065964d9cc93280a7fc4a3334a9410366f9e03a063a92c7a6038b576a6fde3687c7210422b48124d852f29b29c51fa946162ee9ebe4d9c67809cfa98de2ebfe232292a31478acb79aba357162b678d4679c1d3604891b0143166e7e699607e5b1ca4bb7e894a839c7c04316d1581528215e856d9d764b64c6c94f85177125b2470a33b345ab2c7d67c23e882b1741e6d4f6af0984eadcb28e8e83fb497a6ee03ec7df344e94cee00a69fd3f21af9645511b33ac4b96a93b33c9f97c3ac7987edffd48939df5d91c850b3ed080c5159cb497ad5b1af45386b384f76f28f1e8b7cbc2cdc3ba223c4393f99d8d013a3e0d66c2bed452740ae7ad2e6c2a3129717df623c7cf4a9c4dc1394b1bce9c529f3a9d3db7d93948a544f2247ffd4811490734d85976ff8c3bb8c881882096b1ec58d4dbc5b9bca80aa64f24a6486192190db6e1551c84ee3fe6b1528079e20025a9917263a0ea497e128750185bfc8e4a4a814add1963702c78336eed499d57fddd81600cd8c46f258da966b9ac51d6c261081d3e510b8e3f0727f9b11aaeeca53e032b52ae4c854ea59f1500566f0d976513c3ccbd1adb66d5d6f63a10c1b08c0d5c18470ddd3817d11eddd9417c831ca21e962db3f7422558351596820af6dfe14fe7fe7cfb5fcab3e7c4123dcadbd257969aa6e53bb7e1c9e0344f8124c57f9e6217bed10271e5d25a6c5c917af7b6d60969c1a94bd32952296807717d7117cecd2a1a7372d93d8c753c72a3bfc1bb2de822657aec9e02cd8e91c867c95b37e2bf537501ac8d665ed3c2114130b2af812900bac2d91b2b0529e7ff4113f81030f6082b5c90856aa6e6c0d4a2a42e1a1e52bf388fc98bae22c8571c7f79ac11a9825285630ca43cc322e62a0c643a16070881a7880828f6e0e5497d3bd7b0e3e61e03dce408cd04397857c0d3c20047876e8febd8d5a0831c3e9ccb5cc884b24c4a2df1bfa89f7e6e2c62417f5a3257ad2b36f782ea5f085d23c56753a80fdfb7153e11f614497d93d8e6d56f3e6814ebe61956bb80290382d2f2533df31cf1c7dedde9c237b47bac51c13d119ee85a59d8d225931e077495b58b251014a1d5001da576e417d73bf793b26bfa14bd56b07e3d2633309c2395af82309aa5bbe8aa544c5814d3ad7cacc98e364a45cfd8dd2daef43ebf258e3c7b02a417419577e715b7010e55c6c160d7fccc89a41fa2770650c9f47b1ea2242eedee02ff5ed83b326777db1e1619af5807e86b635a9de465a212e8a074380a5f878774071542593d753eb2a3169a0c538890eb0c85ac3ebae86ccef3a07866b6a6f1d0a8fa077df9c846716dc6ca6f57be2574ff078d99a2c87907b952db2654b318268f4839dca52bd69e24e4207b7002b7aaf9db518061d6455fe221dbc0f62f9901cb5f7e4b6e85ae64450a67726643eec5a000a221d80225b81de4aba2fd337ca98baf1f4317bac52cbfa9366fe8ce5fad2d89d2a4f358c7fb2b784d07234fe4aa950dcfa1cf04d8cded18cc495ea493e9c418e66468819c3fff374276d28c5f61490a6b39a9e123429ca775491f0882322241dfb06cb57aad32c60e0ad1d189ec00de67568508bf92e592ebde28ddf083ff64afeaaef010bbf9f3feb9b0b470f3842aae80bc81bd5fd431ebbf8b8ff8a9ba9a70df047b429858280a5a41626e4dbe43d16e6de6e6a9b150b3838a491a0af2e43cf82f540f41ea907155770dbb9e8ba1113691d513c09eaa2d74ff975bb24e75e165fedec818f78af571165fd411f3650ff57641741ee401ae19a91e21674e258eb9539dee0d3f0ea35bc70095091d69993c4eec46c1a1690356650ade949b536824bc18218dc91c3907d2a193cdb9eca09547d139883d008c15d50319423a3697a586f59b338e9ffd9c02293a1d0896eabc9b2dff3b3624c022a2963d3bc1a120308a8a064d863b8278e5b723f18e3597cf53652a5ce23b7c111f0e4457c4b7cae9308d066d2b9507c00318e6a8c90e88d1a367c47cd573a5a1910134ad675bd907ac11ae240553352ff6bf1489fc479abeac7ec912111701d00d49ac7ee30c982d5d5e5d752d66a1385b57ae6d97c4be165efbe5a8e51f511324d2e0c1bccb455ef86940b90bfbbacf2d5d9b3075174a913d8f617a0f01c77ad632dadb1de6f340e684c6930946994532b90fcb582330bd5723470857efa249875c2077a39f2f2b84912caebad539fe3cbb6fc7756c6d4221446a7b248199cf3d8b8fc72b61d526ac793b7dfb8b299074ef318295727d10a042083ed52aa86f3c022f3109efc856604859f7d26d365a1a22609bb728427e2294a1413c2bc48467b21f041003cf761c5597ca35f03d6b059270eeb589d466f521124c5eabab5991da653787a550d91c4016b1229a054ff2573259839af4024520c9b1205332e3ad2f899fd046f7ae9661d039b0a5755c12365f64c411d33bacdb5d0e436c9c5045a8640cf2b567315d980eb633336ab7ed155e5a2b2beb99085ee71cc14a64fa21ff72e686237743bd1461adfe0bd714aa796eff43d5b2492df3844f0f07e96281fab30235ed08f656e6418bb835ee4775f6d6086a71cb0e704e9d0c78f206579d318705ea671b647122b01fc87d2943c49ed5113f46a8ca632b4340d518055f7387f82a1373bf806a1703df221a31490b8ae4fca4b5bb94b947bf39f4d93d4586ec8e4a5665620efe0c7f4a9173fa6556d24b361b46e5e76009191952ae014e34cd4d2d381b36acefbcb8fd358f062fbc7b397cf17a5627309a3aa19bad31da924d5f953dfa2b07d08a2488025574875d1e1c17da3e265511bd1c4d43788158486e5b4f1b6c7bfd5269de266cc81d488a871b0da170b89d0b3e529e9e80714a9a80869dbe8d52273670dd5b0b03300944fac2cd91a66d1805eb96230d0d24a1b6d824222e90ae15e31ebca4d8938df9c7169d31e30c66977ee6863b03e5116d74bc61ecc50ca22f260a90f8293697c3ab20f941b0ebd84ee51b51ab11066aad57ebc60fd1eb31393915970dbf983cac38d866b74447199ad2e8826e1f5c0c24bf7b6c69cc000282676f8c0bf3eb70c45b5c3fbbf3a9cc26a11c899417f92ec0b85dbbc63047dc0f94f4900482d0f94970dcce61a8a796ea9f127bc7f10732622cc2250d99083d760438b5af09178e28c67fbeceff2d3ec739c3a391d25ec78fad0bbef2afd237e78540d2a1d73969fbee2e61b94b5"));
		   
		   File file=new File("d:key.properties");
	        PrintStream ps = new PrintStream(new FileOutputStream(file));
	        ps.print("key="+des.encrypt(test));
	        ps.close();
		  
		  } catch (Exception e) {
		   // TODO: handle exception
		   e.printStackTrace();
		  }
		 }
	}

