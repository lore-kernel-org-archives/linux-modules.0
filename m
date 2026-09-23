Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2794772AD
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157298; cv=none; b=BbkyIN2mZG5DPwyWLwkIH+qtmmG5iP510dUpA7Gni86fZaQU3xM9DggGt40kAwwNBPDmLSqMob95ZjhCv/n2yNedi8UYkjxmO04cd0m2ZypQZxByrIhMQvQlmjHs0RcDUd1UPm8vcYCaCde8biIq+Xv8j47DYf6WIsYRz7MGb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157298; c=relaxed/simple;
	bh=ZdxK1GCr48Qlv1c1Hfl+hnQ78vR6HcTlKqlOgjft1rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAwQvB8ZcqnloFYwtj3vjHjif+1/b7iS1H5f95ieCwtCwpNchWF84EXX+ghoB8sINXbS6RCbDonUM3PE56P77D9vwi1H7SQzptxpZKTZU2mGZWbpHE7U89gYLqPCibYWGRo4lgMVOLCmh5fTeYizVyMW6ju9ciKlT/OUpsKvF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EJiHz0Z/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EJiHz0Z/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso9220145e9.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790157294; x=1790762094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WVluREN2i8gJSNJYukB9yRNDcg0zafIc1pXUaQsB6Uw=;
        b=EJiHz0Z/Jhk0LDctIQOaQLTYeUOIW89zGmsIDTCVd2jNbczCmq4swQk1h+wZWno1kf
         0JebobCzQSEdT/6CvPIp0IRoJ35iPzDgOUKWzXOXZC5evsnRBny4todNCXMDxMbi1pnW
         z5j23bIuUSTSJXbKz6TvZ5vg7VPGMqHTVS/skPmTzETsHmjjHosBAyWRB03AeECdUKD4
         QPdrT3KzgZlB450ReO10jzNu4AT/spvweTPOY1gsQ0TRIG/ZPfxZ0I+NUqlsHqVAGNrj
         XXLVNL/kab/MoI1KCUadUO4eoRrUOjpFcECeVOzxOHJxQR6dBYBI5VNwEpwtvpcyvCS+
         sCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157294; x=1790762094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVluREN2i8gJSNJYukB9yRNDcg0zafIc1pXUaQsB6Uw=;
        b=PTQE/a5cMZxlD+v+d45srRKHm5f4O3DuS3xk7R5rwh6eRhZ4geN1I0oSUjmBfT8rnu
         mMD4lJCpNJti2o+5cSUnPUUy5RaxlvLRQAQfRlJHaxEP/mWXlSTs06toQY9Z3ygIfjdd
         LC4MLayL/eMF3tReVJv0gZFbXaD3QstkE6yPl4Tunu2OyyfONSt8J5WxmnruzCnfys2r
         QS/bhG5/co+4C/yzcIUySppKAuwBiPc7e/7r+XJmEHgNN66RISBNShb2Kw9L1/Go5LO0
         ZEHmEWRB/trJdKEyqnCY11to99zy7XE9JdsXjLkZb/Znw8NrAUqfBpNp5/A5Y6fDxASU
         Lw6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVnlXTCOJ3c82ZjMgBU6DNG/mf8tI2WLb6/UMG7shAx5ywVWQN3GVfnaaDbkU8utQIGcVckyYgMm6TzAfM@vger.kernel.org
X-Gm-Message-State: AFuF++nHShRhinNb67V/AjiGKY2UdJAe3e3UykCczEjgkJyFMVpVXkls
	Vuf8fVBOAhazg86FRDk4Et/mQ6YxtNBl9/jzoVkOtG5PF817wOKU7sZS/0+0mysADvU=
X-Gm-Gg: AYBFou3QT0jvPR9eNvqnVz2JG+NFINwL3qkgoYG9Cg58Q5MjuykbnwkYvjp0cC8j7Y8
	Q0gURo0hcXlZnB+/7cmfEzAnajwvVPVR4+/7KEQXcGbuSCG1fiz69bWGl5x9bzqjrb+rTX78+bz
	GT8pYN8udotrEU8luUgDcZ7dSK/MaF80+IV9Yelr9ETTMs9Dob/qEeaqyo75rcyObko3zY99SiJ
	3qhKr+OVJdUC3Z0G/pv7TPs05C90GHujmpt+3U3eA59xGoSvwkSLvsqG1mmdrgtkAZngvKlRiOe
	6fTdzYz578fxtVH/sQhew98V5kcfz/NEHkNCh5t7gBr77sqyI9/vjSQrEkGV03BJCs2YF1nGa0I
	JhIAkKxoiAKDb5pAwtYlBUktZpPpRuJncMUUjcpCJTfJoq5nFA5pEmix3W8j8SNGhuke+uTXhru
	J6QB0jLEiAVWn+Ei0jCXsrUxeTnptGnelEQJnPpZmXWY2/ZxMtyW+gNld/Ppx6CuqS2j/3c82L9
	SMvkt60X2rdt7OWg34AvqfxdyOEgzO6ttMNY65uTpALitULW9wd1CMaGjFwJgJnDBvKYVrc
X-Received: by 2002:a05:600c:19d4:b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49fdf0fd9a0mr28571275e9.12.1790157294284;
        Wed, 23 Sep 2026 02:54:54 -0700 (PDT)
Received: from localhost (p200300f65f19a904c64cc79e72c13204.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c64c:c79e:72c1:3204])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fde1d978fsm58006955e9.9.2026.09.23.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:54:53 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:54:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Bradley Morgan <brads@mainlining.org>, 
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <arOfHEsGGglNse7T@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vo7ynkqqolpf7hnx"
Content-Disposition: inline
In-Reply-To: <2026092321-province-yearly-44aa@gregkh>


--vo7ynkqqolpf7hnx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

Hello Greg,

On Wed, Sep 23, 2026 at 11:27:11AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 11:04:46PM +0200, Armin Wolf wrote:
> > Am 22.09.26 um 15:40 schrieb David Lechner:
> >=20
> > > On 9/22/26 2:39 AM, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
> > > > > On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
> > > > > > The ability to add and remove devices from a driver through the=
 sysfs
> > > > > > "bind" and "unbind" files was created all those decades ago as =
a way
> > > > > > that kernel developers can iterate faster, and provide a debugg=
ing way
> > > > > > for users to attempt to add a new device to a driver without ha=
ving to
> > > > > > rebuild their kernel.
> > > > > >=20
> > > > > > This api over the years has been abused and recently come under=
 a major
> > > > > > fuzzing "attack" through tools like syzbot which decided that i=
t would
> > > > > > attempt to just randomly bind any driver to any type of device,=
 causing
> > > > > > loads of unneeded errors and pointless kernel patches to be gen=
erated by
> > > > > > unsuspecting new developers.
> > > > > >=20
> > > > > > Handle all of this by adding a new taint flag, TAINT_FORCED_BIN=
D, which
> > > > > > will be set on the driver if the bind/unbind sysfs files are ev=
er
> > > > > > written to.  This lets kernel developers "know" that a user is
> > > > > > attempting to do something that is not normal, and as such, if =
the
> > > > > > kernel breaks they get to keep the shiny pieces laying around o=
n the
> > > > > > floor.
> > > > > >=20
> > > > > > The flag is 'Y' which was unused, and can remembered as the use=
r is
> > > > > > "yeeting" the device being operated on here (thrown with force =
without
> > > > > > regard for the thing being thrown).
> > > > > >=20
> > > > > > Note, the taint flag gets set _BEFORE_ the bind/unbind callback=
 happens,
> > > > > > as many times crashes/oops/warnings/failures happen within the =
callback,
> > > > > > and the taint flag needs to be there to show what was being att=
empted.
> > > > > > If it were to be set after the callback happens, the oops repor=
t would
> > > > > > not properly reflect what foolishness was being attempted.
> > > > > >=20
> > > > > > Fuzzing tools like syzbot, that doesn't have hand-crafted rules=
 to keep
> > > > > > the tool from hitting bind/unbind, should be run with panic_on_=
taint
> > > > > > enabled so that they fall over and don't continue on, thinking =
that they
> > > > > > actually found a real issue.
> > > > > >=20
> > > > > > Userspace operations that rely on the bind/unbind files
> > > > > I agree that this should be avoided.
> > > > >=20
> > > > > But I also think the biggest offender really is driver_override. =
Specifically,
> > > > > on a hot-pluggable bus a driver must be complient with the device=
 driver
> > > > > lifecycle rules and hence shouldn't break on bind/unbind. I think=
 it would be
> > > > > nice to not taint the kernel for such busses, and only taint on d=
river_override,
> > > > > as I think we'd still want the bug reports for such cases.
> > > > >=20
> > > > > But I think this is fine to leave for a follow-up.
> > > > I fully agree. I'm fine and support tainting on driver_override, but
> > > > bind/unbind are used occasionally in my bubble and I consider drive=
rs
> > > > not handling that properly buggy.
> >=20
> > I fully agree with this, drivers should correctly implement the lifecyc=
le model
> > and not just break when being unbound at a improper time. Drivers suffe=
ring from
> > this can easily break this way when unloading the associated kernel mod=
ule, so this
> > taint is no solution.
>=20
> It's a "solution" in that it tells the developer "hey, the user did
> something odd and unsupported".  rmmod is also not a normal operation,
> there's no requirement that it actually work as it's usually a "best
> effort" type of thing.
>=20
> > > In the IIO subsystem, unbind/rebind is the de-facto way to reset a we=
dged
> > > chip.
> > >=20
> > > A few examples where other reset methods were reject in favor of unbi=
nd/bind:
> > >=20
> > > https://lore.kernel.org/linux-iio/20240727160216.2488ed29@jic23-huawe=
i/
> > >=20
> > > 	This needs documenting as it's custom ABI. Note that we don't often
> > > 	accept custom ABI. Particularly not a hook that seems to reset the
> > > 	device. If you want to do that, unbind and rebind the whole drive[r]
> > > 	so we are in a known state etc.
> > >=20
> > > https://lore.kernel.org/linux-iio/20240720163440.03c713dc@jic23-huawe=
i/
> > >=20
> > > 	Firstly as stated below, we don't provide interfaces for this
> > > 	because it's a heavy weight process that is most of the effort of
> > > 	unbinding and rebinding the driver. So if you need to reset, do that.
> > >=20
> > > https://lore.kernel.org/linux-iio/20250505200609.54756520@jic23-huawe=
i/
> > >=20
> > > 	The solution is to run it once at driver bind. Similar to reset
> > > 	below, if the usecase needs to re do it then unbinding and rebinding
> > > 	the driver reflects the fact we are taking it effectively offline
> > > 	for a while.
> > >=20
> > I also consider bind/unbind to be an official API to interact with devi=
ces,
> > so i want to use them in the future with the WMI subsystem.
>=20
> Why?
>=20
> > AFAIK the underlying reason for this series is that some drivers break =
when
> > being bound to unsupported devices. However IMHO drivers should verify =
that
> > they support a given device inside their .probe callback, and the assoc=
iated
> > bus should only match devices with drivers that explicitly claim suppor=
t for
> > those devices (ignoring driver_override).
>=20
> No, drivers should NOT have to do that in their .probe() function,
> that's what we moved away from decades ago!  The match function should
> handle all of that for you, otherwise it's contant duplication
> everywhere that is unneeded.

Well then you have to accept that root can provoke a null pointer
exception (e.g. by forcing the pwm-tegra driver on a device) because at
least with today's platform bus match function such a match is ok.
=20
> Please, learn from our history, don't make the same mistakes.
>=20
> Now I might be convinced that driver_override is the way to go here, but
> it still feels really odd as again, bind/unbind was created as a driver
> debugging option only, it should NOT be a normal operation that any user
> should rely on.  The driver should "just work" properly instead, without
> requiring manual bind work, as that's not a good model at all.

I agree in principle, but (in my case wifi) drivers are buggy sometimes
(due to missing documentation and/or engineering effort) and being able
to rebind the driver instead of rebooting to get a working device again
is very useful.

So yes, theoretically bind/unbind isn't needed, but theory and practise
differ in practise.

OK, as a compromise: Let's keep the taint (after all that's not
destroying any functionality, just adding a hint for bug reports),
and make driver_override opt-in, which should close an attack surface
(mostly for fuzzers?) and so reduce the amount of bug reports instead of
marking a part of them as tainted only.

Best regards
Uwe

--vo7ynkqqolpf7hnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqzoegACgkQj4D7WH0S
/k5w2Af+Klg1x+XORKkNS2E1qxcAWBCsdnbQ0ltybNAmcLfI1d4qr0WgcoHuii5p
WOu2bUorr148oQBqYv2Z04SSH27vPRJqVWVKDLwTKhhkDVXWYRvppS9Z+KZ5ZrMT
Hx4Nviwt7SBmiNPvgElGvxqRTlKgA0yr0+7/GIBHtQrx4T+iwlNzFyWJu9Gyq2fq
QoGKN32qy1ZBeU0daZPEWZtvgSgpG4CeMIFVI1553ejpwYCCl5XT3KqxcR++YULI
Tajayk3xZoMfautfaS4E3OhBXrHVdjpKJgUCU5o2CZRFj4z/EqJhEO6I7EqinjJP
scI9dJVSDNK/ONJmdXB+ghfK376ljw==
=9woh
-----END PGP SIGNATURE-----

--vo7ynkqqolpf7hnx--
