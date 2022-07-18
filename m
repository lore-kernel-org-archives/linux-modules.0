Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014DC433EF
	for <linux-modules@archiver.kernel.org>; Mon, 18 Jul 2022 14:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiGROYq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGROYp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 18 Jul 2022 10:24:45 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 07:24:44 PDT
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 48E0D26FC
        for <linux-modules@vger.kernel.org>; Mon, 18 Jul 2022 07:24:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E6207C.0000000062D56BFC.0000617D; Mon, 18 Jul 2022 16:19:40 +0200
Date:   Mon, 18 Jul 2022 16:19:40 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     linux-modules@vger.kernel.org
Cc:     mario@twentytwo.helgefjell.de
Subject: Issues in man pages of kmod
Message-ID: <20220718141940.GA24932@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-24957-1658153980-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-24957-1658153980-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear kmod maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including kmod) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. If future reports
should use another channel, please let me know.

Man page: insmod.8
Issue:    insmod -h says: insmod [options] filename [args]

"B<insmod> [I<filename>] [I<module\\ options>...]"
--
Man page: insmod.8
Issue:    the B<dmesg> =E2=86=92 B<dmesg>(1)

"Only the most general of error messages are reported: as the work of tryin=
g "
"to link the module is now done inside the kernel, the B<dmesg> usually giv=
es "
"more information about errors\\&."
--
Man page: insmod.8
Issue:    B<modinfo>(8)  B<depmod>(8) =E2=86=92 B<modinfo>(8), B<depmod>(8)

"B<modprobe>(8), B<rmmod>(8), B<lsmod>(8), B<modinfo>(8)  B<depmod>(8)"
--
Man page: lsmod.8
Issue:    /proc/modules =E2=86=92 I</proc/modules>

"B<lsmod> is a trivial program which nicely formats the contents of the /pr=
oc/"
"modules, showing what kernel modules are currently loaded\\&."
--
Man page: lsmod.8
Issue:    B<modinfo>(8) -> B<modinfo>(8),

"B<insmod>(8), B<modprobe>(8), B<modinfo>(8)  B<depmod>(8)"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-24957-1658153980-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmLVa/wACgkQQbqlJmgq
5nDKRg/+MXLTf0gDuP6mm9DdPpBpZLDGhq6lZPViF/GK92EFklmwHkRbzOvGnr4P
2QYKxA2FFGW2vb0Sf4FL2q8FwXw9r5xiu3r8ErTBbHscFVHK5Zo5BYKXmnMU/UkT
9WR+zLCSR9DHxX/ojB+ML2QXMhGmUMLa0q1Hx4VaCZTjEaHAZYhXIKeYFF+DRvmC
RzHxdxNCKfpdPHSLOmHfFPSIX6iR0d7v4+btrlALhHemZ/WEZA5EUO7U3vijWMAJ
ggsU9WVRXjNitJqftYJfVJF9ccCxDsEW3o+M4dU2uhSAbB19pMT1CSN9s3tgwUKE
hc+ZmMb4VPCMK4USVwy9SVrSVlsPwWprI9U986CmU45X5Tz9dlId/o4p8AVZlPQa
VBZeV+Z/diw3tSN4ahQe0F5dqO25FdQseK1hBC4874B7sCYX0hJxi4Dbx3dl5jat
mBIefpXomwga165ghl8kLv28xH83wPCvB9IcF1Lufvb6xPlH7w4U25DNN2aWyTch
815vusKqcUleQk/sKtQX3yzUHT/BhQWzs+Zn98Ro2ZjxNp5iyToA++P+4TwfeHHp
n/GRIitFEfg4RoroeLwPFRGC/6sMKoUNCqkVE5AChjothL9uUkl5/ywZN4E5YubR
3hyIc6h2fTB1RQ1DQqNlpDcwLiHEgT4UMR5flfPsdTW2mBZxOf4=
=tKl6
-----END PGP SIGNATURE-----

--=_luckmann.name-24957-1658153980-0001-2--
