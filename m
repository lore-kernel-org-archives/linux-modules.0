Return-Path: <SRS0=QLNy=QM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93DC282CB
	for <linux-modules@archiver.kernel.org>; Tue,  5 Feb 2019 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF4420818
	for <linux-modules@archiver.kernel.org>; Tue,  5 Feb 2019 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwif+Wqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfBEVCD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:02:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBEVCD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 5 Feb 2019 16:02:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so392161wml.2
        for <linux-modules@vger.kernel.org>; Tue, 05 Feb 2019 13:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7tuTfwXGBlT4j+boSeeEzQGPNgBSjwzfYsuVwQxPKY=;
        b=uwif+Wqoqkkp4U1hXR/tc1RBYdCeox2TIfXFd9oRSN60DDT+brXz5KH4QNI3Wbtx+L
         n3Viq2vm6QWtv4BpG13aPVQApRHx/Hh3Bz9gg61k/jlDDUP4Q860MxE7fJsygtJjAOBi
         aocjbmijJecC/G+lXUEDpFhfkC3UFiuIaCFpbqjSRcTPoUp2lu2X9ikZ5NSOFtcVIi0q
         N/3ka6yMSA4ggN0GuIIG82aN3SRSJzs6LtNNUxPIhG1lRStVzz/bBY2w/wGkqXX5gOV+
         +afpkfhtlS0lWdy2sUd5Nj06v60Ey+Jj344fwIBxiyoWqRHc+CltWvOCEszcl2elk5YP
         rTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7tuTfwXGBlT4j+boSeeEzQGPNgBSjwzfYsuVwQxPKY=;
        b=RBuoBmPTf5fkODiCwAhE/z9CKsrRfbOvfhgIFuLzHRtBuBOn4XDOn5yaEQd7g3Kff2
         8wLmTDFTYzVhNXpTBiomsMJqHWZxRDSXkLYKCiO97BfDQaW+Q/1MHtvbJNzDO5zAo1WX
         Wd3V3aefzxVoDtHInnkqcDWmfe5su+k/npYJoggEbSet2RmUTHbnxOFlKQbWF51mGpRr
         I1MbbElHVQMfZes9FEYgdaKmA1koImuhrUAmnGC/p1+mLotJHZMTBzqZsIja3wm+H9CM
         COXUicXARwXl8+1BcR8/fnLG/gKcAHM5evfG/kObnjLtRAwKZ3coKhQe9lybhSMny1+5
         CB0Q==
X-Gm-Message-State: AHQUAuYlqYuhFe13Eapk9zW+KRiasR6yIKLZVUw2ouadMfQjtP5uZGmY
        iThgMApPRRRu17wYWNen/wKc8J5xhtv3eZTm0hM=
X-Google-Smtp-Source: AHgI3IYlRgB+ATruiQkMwGN6PCNYyIjlx2zH2rkwq0xbbddzA0TV7tLleCgcROXH+PkUDM/9gFAW8b3M2prBo5zJ60M=
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr409840wme.119.1549400521001;
 Tue, 05 Feb 2019 13:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20190204223249.27531-1-lucas.demarchi@intel.com> <xunymunb6usy.fsf@redhat.com>
In-Reply-To: <xunymunb6usy.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 5 Feb 2019 13:01:49 -0800
Message-ID: <CAKi4VAKr=OvnHuEFM54qPR-NULT-NeZVV_LbeYarOe7U1-HFCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] testsuite: fix modinfo test without openssl
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 4, 2019 at 3:18 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Lucas!
>
> Oops :)
>
> Thanks for fixing that!

These are pushed, together with your patches and other 2 to enable
tests on CI/mkosi

Lucas De Marchi

>
> >>>>> On Mon,  4 Feb 2019 14:32:48 -0800, Lucas De Marchi  wrote:
>
>  > ---
>  >  .../correct-sig_hashalgo-openssl.txt             |  3 +++
>  >  .../test-modinfo/correct-sig_hashalgo.txt        |  3 ++-
>  >  .../test-modinfo/correct-sig_key-openssl.txt     |  3 +++
>  >  .../test-modinfo/correct-sig_key.txt             |  2 +-
>  >  .../test-modinfo/correct-signer-openssl.txt      |  3 +++
>  >  .../test-modinfo/correct-signer.txt              |  2 +-
>  >  testsuite/test-modinfo.c                         | 16 ++++++++++++----
>  >  7 files changed, 25 insertions(+), 7 deletions(-)
>  >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
>  >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
>  >  create mode 100644 testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt
>
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
>  > new file mode 100644
>  > index 0000000..f97c4fa
>  > --- /dev/null
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo-openssl.txt
>  > @@ -0,0 +1,3 @@
>  > +sha1
>  > +sha256
>  > +sha256
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
>  > index f97c4fa..23cb933 100644
>  > --- a/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_hashalgo.txt
>  > @@ -1,3 +1,4 @@
>  >  sha1
>  >  sha256
>  > -sha256
>  > +unknown
>  > +
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
>  > new file mode 100644
>  > index 0000000..25a75a8
>  > --- /dev/null
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key-openssl.txt
>  > @@ -0,0 +1,3 @@
>  > +E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
>  > +E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
>  > +26:DA:C3:EB:0F:0D:1A:56:A2:D8:B2:13:F0:D7:53:47:1D:0D:48:68
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
>  > index 25a75a8..7dc4c6a 100644
>  > --- a/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-sig_key.txt
>  > @@ -1,3 +1,3 @@
>  >  E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
>  >  E3:C8:FC:A7:3F:B3:1D:DE:84:81:EF:38:E3:4C:DE:4B:0C:FD:1B:F9
>  > -26:DA:C3:EB:0F:0D:1A:56:A2:D8:B2:13:F0:D7:53:47:1D:0D:48:68
>  > +
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt b/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt
>  > new file mode 100644
>  > index 0000000..2b979f9
>  > --- /dev/null
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-signer-openssl.txt
>  > @@ -0,0 +1,3 @@
>  > +Magrathea: Glacier signing key
>  > +Magrathea: Glacier signing key
>  > +Build time autogenerated kernel key
>  > diff --git a/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt b/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
>  > index 2b979f9..afe83df 100644
>  > --- a/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
>  > +++ b/testsuite/rootfs-pristine/test-modinfo/correct-signer.txt
>  > @@ -1,3 +1,3 @@
>  >  Magrathea: Glacier signing key
>  >  Magrathea: Glacier signing key
>  > -Build time autogenerated kernel key
>  > +
>  > diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
>  > index 504d9dd..373dc95 100644
>  > --- a/testsuite/test-modinfo.c
>  > +++ b/testsuite/test-modinfo.c
>  > @@ -27,7 +27,7 @@
>
>  >  static const char *progname = ABS_TOP_BUILDDIR "/tools/modinfo";
>
>  > -#define DEFINE_MODINFO_TEST(_field, ...) \
>  > +#define DEFINE_MODINFO_TEST(_field, _flavor, ...) \
>  >  static noreturn int test_modinfo_##_field(const struct test *t) \
>  >  { \
>  >      const char *const args[] = { \
>  > @@ -44,20 +44,28 @@ DEFINE_TEST(test_modinfo_##_field, \
>  >              [TC_ROOTFS] = TESTSUITE_ROOTFS "test-modinfo/", \
>  >      }, \
>  >      .output = { \
>  > -            .out = TESTSUITE_ROOTFS "test-modinfo/correct-" #_field ".txt", \
>  > +            .out = TESTSUITE_ROOTFS "test-modinfo/correct-" #_field #_flavor ".txt", \
>  >      })
>
>  >  #define DEFINE_MODINFO_GENERIC_TEST(_field) \
>  > -    DEFINE_MODINFO_TEST(_field, \
>  > +    DEFINE_MODINFO_TEST(_field, , \
>  >                          "/mod-simple-i386.ko", \
>  >                          "/mod-simple-x86_64.ko", \
>  >                          "/mod-simple-sparc64.ko")
>
>  > +#ifdef ENABLE_OPENSSL
>  >  #define DEFINE_MODINFO_SIGN_TEST(_field) \
>  > -    DEFINE_MODINFO_TEST(_field, \
>  > +    DEFINE_MODINFO_TEST(_field, -openssl, \
>  >                          "/mod-simple-sha1.ko", \
>  >                          "/mod-simple-sha256.ko",    \
>  >                          "/mod-simple-pkcs7.ko")
>  > +#else
>  > +#define DEFINE_MODINFO_SIGN_TEST(_field) \
>  > +    DEFINE_MODINFO_TEST(_field, , \
>  > +                        "/mod-simple-sha1.ko", \
>  > +                        "/mod-simple-sha256.ko",    \
>  > +                        "/mod-simple-pkcs7.ko")
>  > +#endif
>
>  >  DEFINE_MODINFO_GENERIC_TEST(filename);
>  >  DEFINE_MODINFO_GENERIC_TEST(author);
>  > --
>  > 2.20.0
>
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
