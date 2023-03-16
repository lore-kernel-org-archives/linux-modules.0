Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64020C6FD1F
	for <linux-modules@archiver.kernel.org>; Thu, 16 Mar 2023 08:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCPI1I (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 16 Mar 2023 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCPI1H (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Mar 2023 04:27:07 -0400
X-Greylist: delayed 116 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 01:26:42 PDT
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1637B5B57
        for <linux-modules@vger.kernel.org>; Thu, 16 Mar 2023 01:26:42 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Thu, 16 Mar 2023 09:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1678955083; bh=eAiMIawJVEHRNIzwGHXcJ77xYkaQ1jbDV/fvM1sjMzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaasQw761A5hVsPoe7LRQ3E9snK8bTcVeaLyYseMwsdoB+FMvSCNed5f+s2OYn/Jp
         kBWIPR3q8yg0MMGS5EzUfTnHhAZ6noiWAXUSc3FrVbGbUoTwA7CpPbLgDrQ8wDvLE9
         K/8fmNzXB9+OShfgHKi1s3PdnBvoaTg4ZMks1aFg=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 1B4F680C1D;
        Thu, 16 Mar 2023 09:24:44 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 0C46A180DC6; Thu, 16 Mar 2023 09:24:44 +0100 (CET)
Date:   Thu, 16 Mar 2023 09:24:40 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        mcgrof@kernel.org
Subject: Re: [PATCH] kmod: modprobe: Remove holders recursively
Message-ID: <ZBLSTBejsoZQGcNs@buildd.core.avm.de>
References: <20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de>
 <20230315181608.oqjqzgm6mxi4jhqf@ldmartin-desk2.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vMPNnzcTomiyn6b8"
Content-Disposition: inline
In-Reply-To: <20230315181608.oqjqzgm6mxi4jhqf@ldmartin-desk2.lan>
X-purgate-ID: 149429::1678955083-B5FA9D96-382CA607/0/0
X-purgate-type: clean
X-purgate-size: 5238
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--vMPNnzcTomiyn6b8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Mar 2023 09:24:40 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>, mcgrof@kernel.org
Subject: Re: [PATCH] kmod: modprobe: Remove holders recursively

On Wed, Mar 15, 2023 at 11:16:08AM -0700, Lucas De Marchi wrote:
> On Wed, Mar 15, 2023 at 02:48:16PM +0100, Nicolas Schier wrote:
> > From: Nicolas Schier <n.schier@avm.de>
> >=20
> > Remove holders recursively when removal of module holders is requested.
> >=20
> > Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
> > also indirect holders if --remove-holders is set.  For a simple module
> > dependency chain like
> >=20
> >  module3 depends on module2
> >  module2 depends on module1
> >=20
> > 'modprobe -r --remove-holders module1' will remove module3, module2 and
> > module1 in correct order:
> >=20
> >  $ modprobe -r --remove-holders module1 --verbose
> >  rmmod module3
> >  rmmod module2
> >  rmmod module1
> >=20
> > (Actually, it will do the same when specifying module2 or module3 for
> > removal instead of module1.)
> >=20
> > As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
> > remove all three modules, as after removal of module3, module2 does not
> > have any holders and the same holds for module1 after removal of
> > module2:
> >=20
> >  $ modprobe -r module3 --verbose
> >  rmmod module3
> >  rmmod module2
> >  rmmod module1
> >=20
> > Without recursive evaluation of holders, modprobe leaves module1 loaded.
> >=20
> > Unfortunately, '--dry-run --remove-holders' breaks with indirect
> > dependencies.
> >=20
> > Signed-off-by: Nicolas Schier <n.schier@avm.de>
> > ---
> > While commit 42b32d30c38e ("modprobe: Fix holders removal", 2022-03-29)=
 already
> > implements removing first-level holders, indirect holders were not eval=
uated.
> > In a simple module dependency chain like
> >=20
> >      module3 depends on module2
> >      module2 depends on module1
> >=20
> > 'modprobe -r --remove-holders module1' was only considering module2 and=
 module1
> > and thus had to fail as module3 was still loaded and blocking removal of
> > module2.
> >=20
> > By doing recursive depth-first removal this can be fixed for such simple
> > dependency.
>=20
>=20
> the dep exported by the kernel didn't require it to be
> recursive AFAIR because they were always expanded.
> For your case modules.dep should have:
>=20
> 	module3.ko: module2.ko module1.ko
> 	module2.ko: module1.ko
> 	modules1.ko:
>
> Is that not the case anymore? Was it due to a change in the kernel build
> system or something we missed? What kernel are you testing this with?

For modules.dep that is exactly what I see during my tests on v6.1.8 and
v4.9.276 (except the /modules1.ko:/module1.ko:/ typo).  But with both
kernel versions, holders exported via sysfs are only direct users:

    $ sudo modprobe module3
    $ lsmod | grep module
    module3                16384  0
    module2                16384  1 module3
    module1                16384  1 module2
    $ find /sys/module/module{1,2,3}/holders/ -ls
      [...]   0 Mar 16 08:45 /sys/module/module1/holders/
      [...]   0 Mar 16 08:48 /sys/module/module1/holders/module2 -> ../../m=
odule2
      [...]   0 Mar 16 08:47 /sys/module/module2/holders/
      [...]   0 Mar 16 08:48 /sys/module/module2/holders/module3 -> ../../m=
odule3
      [...]   0 Mar 16 08:47 /sys/module/module3/holders/

As far as I remember, that has always been this way; it is definitely
not introduced by recent kernel changes.

Current 'modprobe -r --remove-holders' does only analyse the reported
holders, and does not consider anything from modules.dep.

> We will need a test in the testsuite for that and if it's a change in
> the kernel rather than a bug in kmod, probably revert that change until
> we have things figured out.

I am going to prepare a test for the testsuite and send a v2 within a
few days.

Kind regards,
Nicolas

--vMPNnzcTomiyn6b8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmQS0kgACgkQiMa8nIia
bbhN7Q/9GSAm1GP5p9H3yHeHZW0vUg+NLUeJZce6UZ81rdaAyH/YC9PNeJ/FOnRN
Xs0qyOxwt1nh/QzjTQuWhOO7GXFdafC/7Q9KozGh857TrTmNWbnKJCTDm5qH63+P
y6Hcp4yK251Ci2THaBGr0PHnShWt0CJ+gsChBesUN8BMSTfosIjygpGbveSeUwaQ
RfODxguEwAcxrFg0vm9LVN3Mfssq1sr2utP8MVpVBaMo3qfX8tylGB51ehmB5/Fu
ZV8obv+YgMjdLWc5OvhCHUgaLsCjJRyL3IsbjbyJ37ArNiP0oAQfjEbS1BALQQdB
S3nsTnno3In8Tp0OCBBTTWix1tCE0oY4tuNSWfdqxOxVjAjc+2DpOdvdKW21tCqX
ImU30/KNmLyEkmQFMOWvqmbtV6SJs1JVhCFuKssGWhUnh4p3DLgnWiQWDKOLycCX
JcElSvDifE1xCScjAJLnLcTS7ejgUbpnhbLTkVZI9bp7sXF4hRxTjKk1LSyhu1mR
RhqESw9VCUnyL2C50IVgOODHPX3oYxNqwBxH5ludJM7k+g4ZMTk6t6PWzsXhe7Op
vonGRsN2Wuzn0FhVzbI79CDTEI9aoEf2VX9L9iuQYC5LsHFoGtlMuvCYU75bP1Aj
jYKBVYzKKF5bIt+UjVP0ST6OM79Fqo5qfp+P/W0J+c66t1Hcn2Q=
=DvtX
-----END PGP SIGNATURE-----

--vMPNnzcTomiyn6b8--
