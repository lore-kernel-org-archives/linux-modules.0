Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C136DA0D
	for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062782; cv=none; b=CHeztpMmHzXfUZt2qxre/2/NF07J741uXGcPa7EejB8dNF8xdCZckKwVraDm8ral9EXRRoLnNAWypThNEVFuRdc9z8CbWOT1IVhWPuf0AjpQB+ksePfM1vVWGfL3VtquBmLJV4u8emd7qIaEEzzmZUGa4gVKKyxZZK8oUolEbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062782; c=relaxed/simple;
	bh=dl5o9oQr5B5N85FSOPgTlq/lZbjtY8w27lkb6yxJJ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PewnXyUN8XYWB3oGL3f6kF4Ac08oWOCqNk9UeIroVenVhApKleoF8IKRq/IDDDrIwnENc4Bz4vEDUq8vxFMPldwojfkHlhP5UMhD9BEPfbJmW0dKJJNv1Q/nfSaLNXk33S9jH4S0UEwbZlnV7FQfXrzODldIFPxNLgqQVNWSHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YfL2LgfL; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YfL2LgfL"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1805039f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790062777; x=1790667577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNYq47O4Ws8Dm5U8XTWW+CRMw749gUzSYK16o/QDHGk=;
        b=YfL2LgfLlarjpZs2ZUvAKJZf4AoJMihX3yw8LyVNMzFPzxzFUSicxL9MdAJcxXMGW1
         RrHAdyuiUNn+Zh2I8z3EJnknxUwA7tkEyzOYZIESSIjYggkpqdMXM2i1c1iGokLcp4Kw
         xttkABjul59jUyu8am1aLvK1Dnt4o3P551/GIpScreZHyGRB+ujV/kvvrhj3BC9Vh3Pa
         V5Js6ppUZRHqY1MWgRlqwWtUwOf3zTd9dDEA3DIuROsBgZXzkmSpW6s0sUKMgnl/R4WV
         ER3KVd5Z+luv9zJpOVsXt3/SIqNdw6hwucGB6wAA1CmtHYrxqp74+PbQ2ikUqQPP9IN2
         PCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062777; x=1790667577;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNYq47O4Ws8Dm5U8XTWW+CRMw749gUzSYK16o/QDHGk=;
        b=maT8b5HK+G6yZfiIxKDfa94Sm2Y1Hqq4BT35shEpN6/ZrgWzg8An9WE7SSTMa4OJ/K
         YEH77LnQfso+YwQr7r1DpQniYHhIZIV1eNLaql5q1aWLTEhA7ltmVsA9wENNa6Si5lXj
         ozqqk/6+PQqJH1nL8AJPTcweIitU0cqTpNynqkmDX/ag9ySOd1STx+KQ9YafEvszK6R3
         FR1dNpcV0SajtpM5mKV76Ycgw5m1+meJ43paZ/xRImtzBMp9QZgzzF4OTObWzJS1K375
         tn5q2ei6ZafDBBZKNWewNaFSf/0Tnu0iaJDY3k5gnvHr94jKAFZPMZg4/b38baEc0vcS
         PN9w==
X-Forwarded-Encrypted: i=1; AKwUvBz1UAoPc1eDoryiYyC+l75PR2K+ujeNf76icOyeuGM+Rq4YSjIt2top75ti0mC5rkqYWD3tGl3clJ1guC7z@vger.kernel.org
X-Gm-Message-State: AFuF++lQeLA+jiwsXNw0mBkEL1iqKCcI242HxCamrdu1Ivxw9EDbfuSS
	cyG88/zer5jprLf1RSt4/L/LFFFtwBQn1JFU/GInDvhFsqCQ3ykDuVaqDhdaVAkp5wU=
X-Gm-Gg: AYBFou0A0GZZq9zokaUM+P9sMOZXGLbPwWj25t8X1PGuDyCSVaS57Y5ByXFunXYTzBN
	VQKEYX+oTCtWRR/Zmia1+jFkOZtatPV/tKZt/BvFWm1y34pJYcoyrQyq0o5ErYto6XPuIl81xz2
	Luo4MGRpjsfWNgkznIqphO7SnKOrPwXqp8yFoeeeZFWcROdmzmwl2+Ffy4GNJDRw8Ma+chMbeNr
	p6OCJE2ZvO6tVfnrjo0oFnqgq1EG1T0f+9hbTHiIRKMKyrSnIb/6yGFIRBjAGeDVTqlhlJ52wRk
	k+ISh8RBVilq/3nb+giK2Ey77gaFXiab/iAkB8q9LOEdxonotkuJ31pnEtQSmVII1FYbKdIRMw6
	ZSSeEIHU9iRkx9cQSmIOMFRQ7Xlim2NCQA95YI1eQNUUE9ZN5O3pndDdgQzv3WrvtRTwa3lXcSN
	A4KMHHxuST/1c8JzaLI/kpWgDyYFMFLePptEFeLnqtUGekD1jObNLqDl75pCBLfo7TvH4Pmeqv0
	D4noIIuIQogGRBkvZzQl8u4fY6CZihpNbQZuRTAxL9rKCUH4RpHulOXx7wNmA==
X-Received: by 2002:a05:6000:3111:b0:487:8ef:2fcf with SMTP id ffacd0b85a97d-4871e26b86fmr18280691f8f.38.1790062777241;
        Tue, 22 Sep 2026 00:39:37 -0700 (PDT)
Received: from localhost (p200300f65f19a9041d0e57515b2ea4c8.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d0e:5751:5b2e:a4c8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48862788f61sm2993133f8f.26.2026.09.22.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:39:36 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:39:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <arIvG0nx4LXG9nlW@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikoios7rdkqzgpee"
Content-Disposition: inline
In-Reply-To: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>


--ikoios7rdkqzgpee
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
> On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
> > The ability to add and remove devices from a driver through the sysfs
> > "bind" and "unbind" files was created all those decades ago as a way
> > that kernel developers can iterate faster, and provide a debugging way
> > for users to attempt to add a new device to a driver without having to
> > rebuild their kernel.
> >
> > This api over the years has been abused and recently come under a major
> > fuzzing "attack" through tools like syzbot which decided that it would
> > attempt to just randomly bind any driver to any type of device, causing
> > loads of unneeded errors and pointless kernel patches to be generated by
> > unsuspecting new developers.
> >
> > Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
> > will be set on the driver if the bind/unbind sysfs files are ever
> > written to.  This lets kernel developers "know" that a user is
> > attempting to do something that is not normal, and as such, if the
> > kernel breaks they get to keep the shiny pieces laying around on the
> > floor.
> >
> > The flag is 'Y' which was unused, and can remembered as the user is
> > "yeeting" the device being operated on here (thrown with force without
> > regard for the thing being thrown).
> >
> > Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
> > as many times crashes/oops/warnings/failures happen within the callback,
> > and the taint flag needs to be there to show what was being attempted.
> > If it were to be set after the callback happens, the oops report would
> > not properly reflect what foolishness was being attempted.
> >
> > Fuzzing tools like syzbot, that doesn't have hand-crafted rules to keep
> > the tool from hitting bind/unbind, should be run with panic_on_taint
> > enabled so that they fall over and don't continue on, thinking that they
> > actually found a real issue.
> >
> > Userspace operations that rely on the bind/unbind files
>=20
> I agree that this should be avoided.
>=20
> But I also think the biggest offender really is driver_override. Specific=
ally,
> on a hot-pluggable bus a driver must be complient with the device driver
> lifecycle rules and hence shouldn't break on bind/unbind. I think it woul=
d be
> nice to not taint the kernel for such busses, and only taint on driver_ov=
erride,
> as I think we'd still want the bug reports for such cases.
>=20
> But I think this is fine to leave for a follow-up.

I fully agree. I'm fine and support tainting on driver_override, but
bind/unbind are used occasionally in my bubble and I consider drivers
not handling that properly buggy.

So please let's do

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index c51ad96d4de4..ce8fb14ea19a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -242,7 +242,6 @@ static ssize_t unbind_store(struct device_driver *drv, =
const char *buf,
=20
 	dev =3D bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver =3D=3D drv) {
-		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
 		device_driver_detach(dev);
 		err =3D count;
 	}
@@ -266,7 +265,6 @@ static ssize_t bind_store(struct device_driver *drv, co=
nst char *buf,
=20
 	dev =3D bus_find_device_by_name(bus, NULL, buf);
 	if (dev && driver_match_device(drv, dev)) {
-		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
 		err =3D device_driver_attach(drv, dev);
 		if (!err) {
 			/* success */
@@ -513,6 +511,7 @@ static ssize_t driver_override_store(struct device *dev,
 {
 	int ret;
=20
+	add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
 	ret =3D __device_set_driver_override(dev, buf, count);
 	if (ret)
 		return ret;

(plus the needed documentation adaptions and maybe a rename
s/TAINT_FORCED_BIND/TAINT_DRIVER_OVERRIDE/).

Best regards
Uwe

--ikoios7rdkqzgpee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqyMLQACgkQj4D7WH0S
/k5o6wf/QvL9FWWzFHpKfbzsuAgBOWn5AxVXK3QYhCnvpoqfBJNUrHxYRK4N19fK
lu4zMQZiIF3pIma55K4HT/BspgIU2PEntjwd3qv5PXAJVEIC4zi94t6jtsjwzfyh
ICPjAIOv/7a9Hs+DxIFIYAynmaljcmJ9KJQFX+THv55SkTbrvlMBJy5hf8TaH/He
ZKqYDooGLkS4SnRCuALcqrfQ1nFewrCtmGAPrycGrRrmozUmhsbkWpKdPig0wtfg
y0qv6g2TrwzvGsclwxgMYqEmLjdVs4GRzN5dnqIdnaTXlk1WtEtJlx4wZ6Ff53dV
aolAtJZL8PkYcEJ0fpeNtFJvZzxMbg==
=j+xR
-----END PGP SIGNATURE-----

--ikoios7rdkqzgpee--
