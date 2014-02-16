Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:49879 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753736AbaBPVmG (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 16 Feb 2014 16:42:06 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
	by gentp.lnet (Postfix) with ESMTP id 2B496260243
	for <linux-modules@vger.kernel.org>; Sun, 16 Feb 2014 22:23:43 +0100 (CET)
Date: Sun, 16 Feb 2014 22:23:40 +0100
From: Luis Ressel <aranea@aixah.de>
To: linux-modules@vger.kernel.org
Subject: Proposal: Add a depmod wrapper for kmod to aid SELinux
Message-ID: <20140216222340.153307f5@gentp.lnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/x3tSdLoDz5uvy65Qbmh+_FJ"; protocol="application/pgp-signature"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--Sig_/x3tSdLoDz5uvy65Qbmh+_FJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,


I've got a small proposal for kmod which would be helpful for SELinux
users. First of all, I'll give some background (if you're not
interested in that, you can skip the next two paragraphs):

As you may know, SELinux is is an optional kernel subsystem which gives
finer control over permissions than the standard Unix DAC
(Discretionary Access Controls - the normal read/write/execute bits).
Basically, it attaches labels ("contexts") to files and processes and
bases the decision whether to allow or not to allow a specific action
upon these contexts.

For multi-call binaries like kmod, this labeling is problematic: The
kmod tool "depmod" requires a different set of permissions than the
rest of the kmod tools, and should therefore get a different label.
However, all of the kmod tools are only symlinks to /bin/kmod - and due
to technical limitations, we can only attach labels to files, but not to
symlinks.

Thus, it would be useful if you could add wrapper binary to the kmod
distribution, basically just an
"execl("/bin/kmod", "/sbin/depmod", NULL);" call. This would behave
exactly the same as a symlink, but would allow SELinux policies to
label that binary differently. Of course, this doesn't have to be
done for every user; it could be optional on a ./configure option
"--enable-depmod-wrapper".

What do you think? Would you accept such a patch?


Regards,
Luis Ressel

--Sig_/x3tSdLoDz5uvy65Qbmh+_FJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJTASxcXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fp61QP/iHTH9ViLe+ALt2z+/AXncB3
WIQUMc7VqqItwh1p1ktvywU+SLuSwnKKFKnsD0rMZue288R2biVMnWhkeh/ZzGpc
6pkmFRUn0/kMFW4y02ICerZ6Mjg/iYiUhCV9d2Y6x3QmAavgCTU1PpsMo1XKYBDL
/Ka3/Zsuw62agQ0qizM/FmjWuR253msQrn7xrSUgvdtZXweZhDocpc+HvFJ7PLen
sMp2QWzy0TfcDJh86Nbn0FcITzs3eLQk56CG00i26mqh+V/4zSNDfT3+0SC77KxU
IReeL2bTXyf0p6sRfsD7wN+QGiFcka+Iz1qAWBS1/wctG/IwmeXEoyY1FAivOG4c
m4S07GZv7V1VZM/nBQFPNMRSPaQkCtNezj5bgqaRrjywev1+mlnmRb20nhJJuVJY
+hMG0wfWOuhyhhReMfmRSgJbV+5+boEKJ5cQsK9Rs80PbcjlzdjPSWw5rT2wYqsI
6MNxGFu3M6V8EUVhCb1/r3v2fTmE7+eyWPaJTtxx+L9vN6wQ6jd19zbL9z3qULJV
Z7gDE0Wd7meLyuP8hKOoTiqG36pF9taHZALDrM1q5FC/lTkWvBGDYySNZb9RQA61
zoOyqx9iXwZtiHe9rTjERrEeWp+GHH6lxYQusB9RLDs2tqvVNR9/bVJsM8+NSYG+
oPPXZeR304n3xfTwL4VS
=uHT6
-----END PGP SIGNATURE-----

--Sig_/x3tSdLoDz5uvy65Qbmh+_FJ--
