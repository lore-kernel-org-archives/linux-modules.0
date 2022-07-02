Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1959C43334
	for <linux-modules@archiver.kernel.org>; Sat,  2 Jul 2022 17:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGBRU3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 2 Jul 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRU3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 2 Jul 2022 13:20:29 -0400
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 10:20:26 PDT
Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681CDFB5
        for <linux-modules@vger.kernel.org>; Sat,  2 Jul 2022 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1656782044; h=date : to : subject
 : message-id : mime-version : content-type : from : from;
 bh=Lo3qOYOOZ4+7lbeSblH/Dhy2+ON/WsXqvRdKZJ3scDU=;
 b=DhsyyfdWzFUMF0N5wB/udHF6qZgMKufiXjtKTeQ/yMFjkLvpekzk9EAZRsLfqiEO/p1H+
 UDbYtsArfc3COqqxO5UZTDjl2W2DTP5M8ZLC9xHyZjoNAV94bzGvk3tVUmhGQJ0eaAjTCmy
 5Me1ez101dltoY1n6xhwuAlNEbW5mdc=
Received: by attila.bofh.it (Postfix, from userid 10)
        id E236417C08C6; Sat,  2 Jul 2022 19:14:04 +0200 (CEST)
Received: by bongo.bofh.it (Postfix, from userid 1000)
        id E7E19842525; Sat,  2 Jul 2022 19:13:53 +0200 (CEST)
Date:   Sat, 2 Jul 2022 19:13:53 +0200
To:     linux-modules@vger.kernel.org
Subject: test suite failure for get_backoff_delta_msec()
Message-ID: <YsB80cliBmGcnPTD@bongo.bofh.it>
Mail-Followup-To: linux-modules@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6UVnn4zTSb/VZgKJ"
Content-Disposition: inline
From:   Marco d'Itri <md@Linux.IT>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--6UVnn4zTSb/VZgKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

v30:

$ ./test-util=20
TESTSUITE: running test_backoff_time, in forked context
TESTSUITE: ERR: Failed assertion: delta =3D=3D 1 ../testsuite/test-util.c:2=
38 test_backoff_time
TESTSUITE: ERR: 'test_backoff_time' [3118348] exited with return code 1
TESTSUITE: ERR: FAILED: test_backoff_time
TESTSUITE: ------
$


write(1, "TESTSUITE: running test_backoff_time, in forked context\n", 56TES=
TSUITE: running test_backoff_time, in forked context
) =3D 56
clone(child_stack=3DNULL, flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|S=
IGCHLDstrace: Process 3118835 attached
, child_tidptr=3D0x7fc93eb33a10) =3D 3118835
[pid 3118834] close(4 <unfinished ...>
[pid 3118835] prctl(PR_SET_PDEATHSIG, SIGTERM <unfinished ...>
[pid 3118834] <... close resumed>)      =3D 0
[pid 3118835] <... prctl resumed>)      =3D 0
[pid 3118834] epoll_create1(EPOLL_CLOEXEC) =3D 4
[pid 3118835] close(3)                  =3D 0
[pid 3118834] epoll_ctl(4, EPOLL_CTL_ADD, 3, {EPOLLHUP, {u32=3D2034464432, =
u64=3D94873567065776}}) =3D 0
[pid 3118835] write(1, "TESTSUITE: ERR: Failed assertion: delta =3D=3D 1 ..=
/testsuite/test-util.c:238 test_backoff_time\n", 92TESTSUITE: ERR: Failed a=
ssertion: delta =3D=3D 1 ../testsuite/test-util.c:238 test_backoff_time
 <unfinished ...>
[pid 3118834] epoll_wait(4,  <unfinished ...>
[pid 3118835] <... write resumed>)      =3D 92
[pid 3118835] exit_group(1)             =3D ?
[pid 3118834] <... epoll_wait resumed>[{EPOLLHUP, {u32=3D2034464432, u64=3D=
94873567065776}}], 4, 2000) =3D 1
[pid 3118835] +++ exited with 1 +++

--=20
ciao,
Marco

--6UVnn4zTSb/VZgKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQnKUXNg20437dCfobLPsM64d7XgQUCYsB80QAKCRDLPsM64d7X
gWPfAP4lHI8xbntroF5nWWxWNu85Q0hXJMw83RzSxi9+YTELUQD/a7zZ+eOruNr7
CAY3Zvj9EIgr43ZlD4fVTQ9/T7MYSwg=
=lAWR
-----END PGP SIGNATURE-----

--6UVnn4zTSb/VZgKJ--
