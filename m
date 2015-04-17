Return-Path: <alexander.haenel-baas@sieb-meyer.de>
From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
To: "Lucas De Marchi (lucas.de.marchi@gmail.com)" <lucas.de.marchi@gmail.com>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: modules out of tree issue
Date: Fri, 17 Apr 2015 09:41:45 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342963137@SMExchange01.siebmeyer.org>
Content-Type: multipart/alternative;
	boundary="_000_9BA84827B30CBE4996725F98F7DC912342963137SMExchange01sie_"
MIME-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

--_000_9BA84827B30CBE4996725F98F7DC912342963137SMExchange01sie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Lucas

i have played with the make files and find out that the problem is the
OUTDIR setting in the TARGET.

makefile:
OUTDIR=3Dout/
SOURCES =3D internal/src/sm36502_uio.o
TARGET=3D${OUTDIR}alex                                <-- works not

OBJECTS :=3D $(SOURCES:.c=3D.o)
obj-m :=3D $(TARGET).o
$(TARGET)-y :=3D $(OBJECTS)

This works NOT at Kernel 3.18 but with older kernels

I miss the compile state and get:
sm@debianVM:~/temp/ARMg3k036502Uio$ make
make  ARCH=3Darm CROSS_COMPILE=3D/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3Xeno=
ArmImx.Bsp.V2/selected_toolchain/arm-v7a-linux-gnueabi- -C /opt/g3DevelBase=
/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/platform-sm-arm/build-target/linux-=
3.18 M=3D$PWD  modules
make[1]: Entering directory `/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmI=
mx.Bsp.V2/platform-sm-arm/build-target/linux-3.18'
LD [M]  /home/sm/temp/ARMg3k036502Uio/out/alex.o
/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/selected_toolchain/=
arm-v7a-linux-gnueabi-ld: no input files

Without given OUTDIR in TARGET it works.

makefile:
SOURCES =3D internal/src/sm36502_uio.o
TARGET=3Dalex                                                      <--NO  p=
roblem

OBJECTS :=3D $(SOURCES:.c=3D.o)
obj-m :=3D $(TARGET).o
$(TARGET)-y :=3D $(OBJECTS)

sm@debianVM:~/temp/ARMg3k036502Uio$ make
make  ARCH=3Darm CROSS_COMPILE=3D/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3Xeno=
ArmImx.Bsp.V2/selected_toolchain/arm-v7a-linux-gnueabi- -C /opt/g3DevelBase=
/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/platform-sm-arm/build-target/linux-=
3.18 M=3D$PWD  modules
make[1]: Entering directory `/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmI=
mx.Bsp.V2/platform-sm-arm/build-target/linux-3.18'
CC [M]  /home/sm/temp/ARMg3k036502Uio/internal/src/sm36502_uio.o
  LD [M]  /home/sm/temp/ARMg3k036502Uio/alex.o
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/sm/temp/ARMg3k036502Uio/alex.mod.o
  LD [M]  /home/sm/temp/ARMg3k036502Uio/alex.ko

Then I played with kernelversion too:
3.17.8 works with my OUTDIR in TARGET
3.18 works not

I found a diff in /scripts/Makefile.build

@@ -386,7 +386,7 @@
               $(call if_changed,link_multi-y)
$(call multi_depend, $(multi-used-y), .o, -objs -y)
+$(multi-used-m): FORCE
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
               $(call if_changed,link_multi-m)
               @{ echo $(@:.o=3D.ko); echo $(link_multi_deps); } > $(MODVER=
DIR)/$(@F:.o=3D.mod)
$(call multi_depend, $(multi-used-m), .o, -objs -y)

I'm not sure but the dependencies are lost???

When I set $(multi-used-m): FORCE  to  $(multi-used-m) : %.o: $(multi-objs-=
m) FORCE in the makefile.build,
all my modules make files are lucky.

I hope that helps to find out what is going wrong and we find a solution ho=
w I can
use a outputdir in the makefile.


With best regards,
Alexander


--_000_9BA84827B30CBE4996725F98F7DC912342963137SMExchange01sie_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Sprechblasentext Zchn";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:EN-US;}
span.E-MailFormatvorlage17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.SprechblasentextZchn
	{mso-style-name:"Sprechblasentext Zchn";
	mso-style-priority:99;
	mso-style-link:Sprechblasentext;
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Lucas<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">i have played with the make fil=
es and find out that the problem is the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OUTDIR setting in the TARGET.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">makefile:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OUTDIR=3Dout/<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SOURCES =3D internal/src/sm3650=
2_uio.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">TARGET=3D${OUTDIR}alex &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;-- works not<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OBJECTS :=3D $(SOURCES:.c=3D.o)=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">obj-m :=3D $(TARGET).o<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">$(TARGET)-y :=3D $(OBJECTS)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This works NOT at Kernel 3.18 b=
ut with older kernels<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I miss the compile state and ge=
t:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sm@debianVM:~/temp/ARMg3k036502=
Uio$ make<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make&nbsp; ARCH=3Darm CROSS_COM=
PILE=3D/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/selected_too=
lchain/arm-v7a-linux-gnueabi- -C /opt/g3DevelBase/g3Toolchain/g3Bsp/sd3Xeno=
ArmImx.Bsp.V2/platform-sm-arm/build-target/linux-3.18
 M=3D$PWD&nbsp; modules<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[1]: Entering directory `/o=
pt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/platform-sm-arm/build=
-target/linux-3.18'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">LD [M]&nbsp; /home/sm/temp/ARMg=
3k036502Uio/out/alex.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/opt/g3DevelBase/g3Toolchain/g3=
Bsp/sd3XenoArmImx.Bsp.V2/selected_toolchain/arm-v7a-linux-gnueabi-ld: no in=
put files<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Without given OUTDIR in TARGET =
it works.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">makefile:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SOURCES =3D internal/src/sm3650=
2_uio.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">TARGET=3Dalex &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&lt;--NO &nbsp;problem<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OBJECTS :=3D $(SOURCES:.c=3D.o)=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">obj-m :=3D $(TARGET).o<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">$(TARGET)-y :=3D $(OBJECTS)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sm@debianVM:~/temp/ARMg3k036502=
Uio$ make<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make&nbsp; ARCH=3Darm CROSS_COM=
PILE=3D/opt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/selected_too=
lchain/arm-v7a-linux-gnueabi- -C /opt/g3DevelBase/g3Toolchain/g3Bsp/sd3Xeno=
ArmImx.Bsp.V2/platform-sm-arm/build-target/linux-3.18
 M=3D$PWD&nbsp; modules<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">make[1]: Entering directory `/o=
pt/g3DevelBase/g3Toolchain/g3Bsp/sd3XenoArmImx.Bsp.V2/platform-sm-arm/build=
-target/linux-3.18'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">CC [M]&nbsp; /home/sm/temp/ARMg=
3k036502Uio/internal/src/sm36502_uio.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; LD [M]&nbsp; /home/sm/te=
mp/ARMg3k036502Uio/alex.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Building modules, stage =
2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; MODPOST 1 modules<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; CC&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /home/sm/temp/ARMg3k036502Uio/alex.mod.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; LD [M]&nbsp; /home/sm/te=
mp/ARMg3k036502Uio/alex.ko<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Then I played with kernelversio=
n too:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3.17.8 works with my OUTDIR in =
TARGET<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3.18 works not<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found a diff in /scripts/Make=
file.build
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -386,7 &#43;386,7 @@<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(call if_changed,lin=
k_multi-y)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">$(call multi_depend, $(multi-us=
ed-y), .o, -objs -y)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;$(multi-used-m): FORCE<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-$(multi-used-m) : %.o: $(multi=
-objs-m) FORCE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(call if_changed,lin=
k_multi-m)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @{ echo $(@:.o=3D.ko)=
; echo $(link_multi_deps); } &gt; $(MODVERDIR)/$(@F:.o=3D.mod)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">$(call multi_depend, $(multi-us=
ed-m), .o, -objs -y)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I&#8217;m not sure but the depe=
ndencies are lost???
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When I set $(multi-used-m): FOR=
CE &nbsp;to &nbsp;$(multi-used-m) : %.o: $(multi-objs-m) FORCE in the makef=
ile.build,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">all my modules make files are l=
ucky.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I hope that helps to find out w=
hat is going wrong and we find a solution how I can<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">use a outputdir in the makefile=
.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:DE">With best re=
gards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:DE">Alexander <o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_9BA84827B30CBE4996725F98F7DC912342963137SMExchange01sie_--
