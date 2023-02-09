Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4AC05027
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 14:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBIOP7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBIOP6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 09:15:58 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33268A7A
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 06:15:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-52bf225460cso26896477b3.4
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 06:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfXxPU7eruWQU/CmHa9v+66140luOTxDTo3BAH/7o1M=;
        b=MQ4GyT5jPF2UTW7/lzGqjxW0n5F+cV4yqeUBlMeMNekoOYyll9gsgIufMzCHNCXvLo
         MndfIC+9N5nWWscjHmNz++/798RgO+nY4idMtwrFBB2rpbxVEHZZu+DbFBFOivH8ZHnH
         yVv7+XbssgKylYy0tAhqshZqEIioaBjdxvCUE+33KLC3pScOlzR/pbDyqIRZj1fcRBzN
         XRVoB27Hr0Ai+mqouXckFEX6llZGVbovKEyFykf6oYyU8NAF9ELVuiGTaLPcnlFoIluS
         i718t/QVmNE74pmdp8y8Y1t+ZpNBe80tOxAwtdZ80R4TZXbEHPlHujaa2euvmIgtSj3H
         26Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfXxPU7eruWQU/CmHa9v+66140luOTxDTo3BAH/7o1M=;
        b=IN73fdNeKswV13Fr0WaMSSREiKNW+F4Pm98beKJ9chExoplzdRx/dTfktFhUHWs3Pi
         8ir3o5eRtsZEXwcpU7+EWeJKWAEmyko8OScRBy4pXhS8lX/LEicBAnITmh/RBshF4LAM
         ZMpxD6aYcQDjnfA/U7Q2AaGNvQB6WpNTuRQMCFQB27/9Br446gJJ1TCWOfGNWRpfDpRD
         fRFWsc3SegKJoqKGf5QqJpLXvaDtxHdx321Xc9rd6bgNXkS6I4iIG8m5Ip8MeKrwpOMC
         AvbbvB9my5CIr+AacAGOfMZF1h8u+0yT0v5K+uaxeyqioM/B7I2bwj1gUmFossFDKeIP
         cNOA==
X-Gm-Message-State: AO0yUKWULNMvxwIIsO2BekMD5+PeUwRmiRv5enwerG7AFLdMcI665EDs
        lFjL82+6yUuj3NQzvJr0J+Lj0BSQi2WinrLQXSI=
X-Google-Smtp-Source: AK7set+WfOhsU6UZTHdgc3xfpVFYghEnrZRd8+tS2Ga9qrQTterHIK1dPHKtBsJ06BALICWY9UDqim/yOJqvImXO8H0=
X-Received: by 2002:a81:7507:0:b0:52e:bedf:9f57 with SMTP id
 q7-20020a817507000000b0052ebedf9f57mr112304ywc.328.1675952155830; Thu, 09 Feb
 2023 06:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20230206131834.559229-1-emil.l.velikov@gmail.com> <20230208181854.djyo2oncelbnlakh@ldmartin-desk2.lan>
In-Reply-To: <20230208181854.djyo2oncelbnlakh@ldmartin-desk2.lan>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 9 Feb 2023 14:15:43 +0000
Message-ID: <CACvgo52ibwe2Ea1Ej4ESimCBSbvWr_VE=-P7bJ=_K6VJbqUYKg@mail.gmail.com>
Subject: Re: [PATCH v2] depmod: Introduce outdir option
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, 8 Feb 2023 at 18:19, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Mon, Feb 06, 2023 at 01:18:34PM +0000, Emil Velikov wrote:
> >From: Emil Velikov <emil.velikov@collabora.com>
> >
> >This option is equivalent to basedir, with the small difference being
> >that's where the meta-data files are generated. In other words, this
> >allows us to have read-only input modules and modules.dep, while still
> >being able to generate the meta-data files.
> >
> >Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> >Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> >---
> >Here's a handy feature behind the request at
> >https://github.com/kmod-project/kmod/issues/13
> >
> >v2:
> > - alternative wording for manpage and help screen (thanks Lucas)
> > - add test case
> >
> >NOTE: skipping the test (as well as some surrounding ones) seems
> >dubious, but it's added for consistency. Will send another series with
> >papercuts shortly, to drop that... if applicable that is :-)
> >---
> > man/depmod.xml                                | 20 ++++++++++
> > testsuite/populate-modules.sh                 |  3 ++
> > .../lib/modules/4.4.4/modules.alias           | 37 +++++++++++++++++++
> > .../lib/modules/4.4.4/modules.builtin         |  0
> > .../lib/modules/4.4.4/modules.order           |  7 ++++
> > testsuite/test-depmod.c                       | 34 +++++++++++++++++
> > tools/depmod.c                                | 25 +++++++++++--
> > 7 files changed, 123 insertions(+), 3 deletions(-)
> > create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
> > create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
> > create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
> >
> >diff --git a/man/depmod.xml b/man/depmod.xml
> >index ea0be27..3b00971 100644
> >--- a/man/depmod.xml
> >+++ b/man/depmod.xml
> >@@ -45,6 +45,7 @@
> >     <cmdsynopsis>
> >       <command>depmod</command>
> >       <arg><option>-b <replaceable>basedir</replaceable></option></arg>
> >+      <arg><option>-o <replaceable>outdir</replaceable></option></arg>
> >       <arg><option>-e</option></arg>
> >       <arg><option>-E <replaceable>Module.symvers</replaceable></option></arg>
> >       <arg><option>-F <replaceable>System.map</replaceable></option></arg>
> >@@ -151,6 +152,25 @@
> >           </para>
> >         </listitem>
> >       </varlistentry>
> >+      <varlistentry>
> >+        <term>
> >+          <option>-o <replaceable>outdir</replaceable></option>
> >+        </term>
> >+        <term>
> >+          <option>--outdir <replaceable>outdir</replaceable></option>
> >+        </term>
> >+        <listitem>
> >+          <para>
> >+            Set the output directory where depmod will store any generated file.
> >+            <replaceable>outdir</replaceable> serves as a root to that location,
> >+            similar to how <replaceable>basedir</replaceable> is used. Also this
> >+            setting takes precedence and if used together with
> >+            <replaceable>basedir</replaceable> it will result in the input being
> >+            that directory, but the output being the one set by
> >+            <replaceable>outdir</replaceable>.
> >+          </para>
> >+        </listitem>
> >+      </varlistentry>
> >       <varlistentry>
> >         <term>
> >           <option>-C</option>
> >diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
> >index aa6d5c2..5009cac 100755
> >--- a/testsuite/populate-modules.sh
> >+++ b/testsuite/populate-modules.sh
> >@@ -61,6 +61,9 @@ map=(
> >     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
> >     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
> >     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
> >+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
> >+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
> >+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
> >     ["test-modinfo/mod-simple-i386.ko"]="mod-simple-i386.ko"
> >     ["test-modinfo/mod-simple-x86_64.ko"]="mod-simple-x86_64.ko"
> >     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
> >diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
> >new file mode 100644
> >index 0000000..5675329
> >--- /dev/null
> >+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
> >@@ -0,0 +1,37 @@
> >+# Aliases extracted from modules themselves.
> >+alias pci:v0000103Cd00003230sv0000103Csd0000323Dbc*sc*i* cciss
> >+alias pci:v0000103Cd00003230sv0000103Csd00003237bc*sc*i* cciss
> >+alias pci:v0000103Cd00003238sv0000103Csd00003215bc*sc*i* cciss
> >+alias pci:v0000103Cd00003238sv0000103Csd00003214bc*sc*i* cciss
> >+alias pci:v0000103Cd00003238sv0000103Csd00003213bc*sc*i* cciss
> >+alias pci:v0000103Cd00003238sv0000103Csd00003212bc*sc*i* cciss
> >+alias pci:v0000103Cd00003238sv0000103Csd00003211bc*sc*i* cciss
> >+alias pci:v0000103Cd00003230sv0000103Csd00003235bc*sc*i* cciss
> >+alias pci:v0000103Cd00003230sv0000103Csd00003234bc*sc*i* cciss
> >+alias pci:v0000103Cd00003230sv0000103Csd00003223bc*sc*i* cciss
> >+alias pci:v0000103Cd00003220sv0000103Csd00003225bc*sc*i* cciss
> >+alias pci:v00000E11d00000046sv00000E11sd0000409Dbc*sc*i* cciss
> >+alias pci:v00000E11d00000046sv00000E11sd0000409Cbc*sc*i* cciss
> >+alias pci:v00000E11d00000046sv00000E11sd0000409Bbc*sc*i* cciss
> >+alias pci:v00000E11d00000046sv00000E11sd0000409Abc*sc*i* cciss
> >+alias pci:v00000E11d00000046sv00000E11sd00004091bc*sc*i* cciss
> >+alias pci:v00000E11d0000B178sv00000E11sd00004083bc*sc*i* cciss
> >+alias pci:v00000E11d0000B178sv00000E11sd00004082bc*sc*i* cciss
> >+alias pci:v00000E11d0000B178sv00000E11sd00004080bc*sc*i* cciss
> >+alias pci:v00000E11d0000B060sv00000E11sd00004070bc*sc*i* cciss
> >+alias pci:v0000103Cd*sv*sd*bc01sc04i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003356bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003355bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003354bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003353bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003352bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003351bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Bsv0000103Csd00003350bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003233bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd0000324Bbc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd0000324Abc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003249bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003247bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003245bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003243bc*sc*i* hpsa
> >+alias pci:v0000103Cd0000323Asv0000103Csd00003241bc*sc*i* hpsa
> >diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
> >new file mode 100644
> >index 0000000..e69de29
> >diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
> >new file mode 100644
> >index 0000000..4b64309
> >--- /dev/null
> >+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
> >@@ -0,0 +1,7 @@
> >+#336
> >+kernel/drivers/block/cciss.ko
> >+#2094
> >+kernel/drivers/scsi/scsi_mod.ko
> >+#2137
> >+kernel/drivers/scsi/hpsa.ko
> >+
> >diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
> >index d7802d7..6465230 100644
> >--- a/testsuite/test-depmod.c
> >+++ b/testsuite/test-depmod.c
> >@@ -57,6 +57,40 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
> >               },
> >       });
> >
> >+#define MODULES_OUTDIR_UNAME "4.4.4"
> >+#define MODULES_OUTDIR_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-outdir"
> >+#define MODULES_OUTDIR_LIB_MODULES_OUTPUT MODULES_OUTDIR_ROOTFS "/outdir/lib/modules/" MODULES_OUTDIR_UNAME
> >+#define MODULES_OUTDIR_LIB_MODULES_INPUT MODULES_OUTDIR_ROOTFS "/lib/modules/" MODULES_OUTDIR_UNAME
> >+static noreturn int depmod_modules_outdir(const struct test *t)
> >+{
> >+      const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
> >+      const char *const args[] = {
> >+              progname,
> >+              "--outdir", MODULES_OUTDIR_ROOTFS "/outdir/",
> >+              NULL,
> >+      };
> >+
> >+      test_spawn_prog(progname, args);
> >+      exit(EXIT_FAILURE);
> >+}
> >+
> >+DEFINE_TEST(depmod_modules_outdir,
> >+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
> >+        .skip = true,
> >+#endif
> >+      .description = "check if depmod honours the outdir option",
> >+      .config = {
> >+              [TC_UNAME_R] = MODULES_OUTDIR_UNAME,
> >+              [TC_ROOTFS] = MODULES_OUTDIR_ROOTFS,
> >+      },
> >+      .output = {
> >+              .files = (const struct keyval[]) {
> >+                      { MODULES_OUTDIR_LIB_MODULES_OUTPUT "/modules.alias",
> >+                        MODULES_OUTDIR_LIB_MODULES_INPUT "/modules.alias" },
>
> I think this is a little bit weird because modules.alias is not really
> used as input. It's always produced by depmod, i.e. an output I propose we do 2 things:
>
> 1) move the correct files we are using to compare to MODULES_OUTDIR_ROOTFS
> 2) also compare modules.dep, because we then ensure the outdirname is
> being correctly stripped off the output.
>
> I just gave this a try with the additional diff on top. If you agree, I
> can squash in your commit before pushing.
>

Of course, the extra chunk looks reasonable, Thank you o/

Emil
