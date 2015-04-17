Return-Path: <alexander.haenel-baas@sieb-meyer.de>
From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
To: "Lucas De Marchi (lucas.de.marchi@gmail.com)" <lucas.de.marchi@gmail.com>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: modules out of tree issue
Date: Fri, 17 Apr 2015 09:48:12 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342963153@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

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

I found a diff in /scripts/Makefile.build=20

@@ -386,7 +386,7 @@
               $(call if_changed,link_multi-y)
$(call multi_depend, $(multi-used-y), .o, -objs -y)

+$(multi-used-m): FORCE
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
               $(call if_changed,link_multi-m)
               @{ echo $(@:.o=3D.ko); echo $(link_multi_deps); } > $(MODVER=
DIR)/$(@F:.o=3D.mod)
$(call multi_depend, $(multi-used-m), .o, -objs -y)

I'm not sure but the dependencies are lost???=20

When I set $(multi-used-m): FORCE  to  $(multi-used-m) : %.o: $(multi-objs-=
m) FORCE in the makefile.build,
all my modules make files are lucky.

I hope that helps to find out what is going wrong and we find a solution ho=
w I can
use a outputdir in the makefile.


---
Alexander=20
