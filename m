Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:55459 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600AbaBRSKd (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 18 Feb 2014 13:10:33 -0500
Date: Tue, 18 Feb 2014 19:10:20 +0100
From: Luis Ressel <aranea@aixah.de>
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: Proposal: Add a depmod wrapper for kmod to aid SELinux
Message-ID: <20140218191020.12a65822@gentp.lnet>
In-Reply-To: <CA+5PVA417O+uny=q5yZk22gVZi2zojrUGHQrq05XuXDUSW_KgA@mail.gmail.com>
References: <20140216222340.153307f5@gentp.lnet>
	<CA+5PVA417O+uny=q5yZk22gVZi2zojrUGHQrq05XuXDUSW_KgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/wWOlqah7cYvXvf5G2tnvXt_"; protocol="application/pgp-signature"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--Sig_/wWOlqah7cYvXvf5G2tnvXt_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2014 08:47:05 -0500
Josh Boyer <jwboyer@fedoraproject.org> wrote:

> Can you elaborate on the different set of SELinux labels/permissions
> for depmod?  Fedora ships with SELinux enforcing enabled and we've not
> had any issues with depmod being under the system_u:object_r:bin_t:s0
> label.  I'm curious what you're trying to set depmod to and why.

That's because Fedora uses a "targeted" SELinux policy by default and
therefore only restricts the permissions of daemons. Users are
"unconfined" - they keep their full permission set. Depmod is called
interactively and gets full root access, just as without SELinux.

I use a "strict" policy which also restricts users. In that case, root
normally doesn't have the permissions needed by modprobe or depmod.
Thus, they have to be labeled specially: depmod_t for depmod and
insmod_t for the other kmod tools.

> This seems somewhat over-engineered.  Wouldn't it be simpler to copy
> the kmod binary itself to a real file called 'depmod' during the
> installation?

You're absolutely right. I just didn't think of that. In some cases
this might create an unpleasant size overhead, but for kmod that
overhead is negligible. Since kmod's make install target doesn't create
the symlinks, it also doesn't have to care about this. I therefore
withdraw my proposal.

However, in case you add the functionality of creating the symlinks to
the Makefile in the future, it would be neat to offer this approach as
a configurable alternative. (Only for depmod, though, the other tools
can stay symlinks).


Regards,
Luis Ressel

--Sig_/wWOlqah7cYvXvf5G2tnvXt_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJTA6IMXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpkcwQAK5NmvVOe7Ql7GRngFjOItAt
NQQYPg1AbWP/wjlpZu7qGCU++6DBatpqhDYs3pJDEGvLNWPI2JHdAt/CjKb/4bW+
mN/kV+uXYlDdz9/6B5pSQDHNE9FhNLwHJc3jQ1sqZ/K/1UqDBvlZns0T2xQT4yY7
pYe7G6ZJdUq9kRI8meViYgOlN7Bp/WMEg53BQdtPdtzMoe/vR9qEB2UtQn3zgz+j
6tTKfFziHrjorw9s1XK6d9wedFQ0xlUPmUNI6ZjvU0egm0qww5JJ/igElRJWeBoc
SDHJiOqoYoOFA5We9sk6v1oqwqc3419jpeIAfqtl2ysjjxklx1zV5JZO4+dSquww
MQPrlahMHQivaP0wGA03p8Le3lDv7P6zm84i6FKOhbVqh0lOjUwWT8C3Ne6fcXmh
PCq8mqtlzO1oxDvs2/ZN1eJLJU9QppkXhxUBwNn3sC18f4Si2REqmq1AGiwa1Qdg
whXjB1PyJPpDTBpueBqkWxaBGvnJI1DLii+7ZhQpxhCeW9jka9oj80pgd0+c5R3x
vv01J8Vk+l8sC8lVdMnGrMY5USuen/83gbwLHCVsAzJ4iumlEPkfJEXrQqTgKJUA
qhPOHNBeViEG8x3P5etauH/iRzGGhiYr4VthxhOA2m1Kz24NIvfpXDbjNba1EEEr
dPO6YIUCa1Xvoq4vt0Zb
=Qwf2
-----END PGP SIGNATURE-----

--Sig_/wWOlqah7cYvXvf5G2tnvXt_--
