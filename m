Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793053538;
	b=5mwCEwVJ7y5dOtxetzN1PJVsh8Y5WVPmOhKXDjIBx7aRXpZEs5fOJ7Buw18OpnOYkIhp
	 ZV3MOPmiydCDCk6Uy2e0oBL6YuOxGZ1qk2mkd9HZlhv8QjIRdhLumTv9aSM0BLtEWcnyA
	 7y8yS8Bp855/aYD4S6P4LDPWHXPnlzIaKWKdeElhG2kBzGHfT44u07MRNwEffX5ariv6m
	 jkP3tv300RHUo5wqtoz5TdsvD+QbWafohRP/5uVeCHxfyMwpg2X9uIqv8Q7B3y+ytowLe
	 NIr8ebY0pti5u1MZsUiazRWyhY6XYJrjWlM0ROh/XILqA4Iiuh/D2Ex2bizL6eZ3IBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
	b=p1Mi3jzGcn0/LoiHY+yXZu7jfAQJ9dl30Q4W4E8zqWzAYQqvhbUtGQav+ho3HzrAgYH1
	 +IHwKLl0O/8R6M/3Jo9BqSyLUShBy59v+yTLq/Z9mUYdSyrv9kE+MsNP65gBRwvRxJG30
	 lNLr/6Iq1CgY41JKp/UBg+LqZxjr0PFl17hfKhewnxIN/cwBs7zjRSNMzGx93zaLnQ3MO
	 7ZhM3uw6CseMyv+26FCsFrNeKXsjtQ20OEJQvU+YJg7Usyx61cdG9eGVgYl6ynqgRseBp
	 eERUPRSEi5R5QSa2chf3ExoCiQLKXJYkTf6njiaPvWCr+7yPx19F+K26+/0/MlimUiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WBXXhweS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDE606A31B
	for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1DDE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WBXXhweS
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67a2bd0c297so3159528d50.2
        for <linux-modules@vger.kernel.org>; Mon, 26 Oct 2026 15:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793053537; cv=none;
        d=google.com; s=arc-20260327;
        b=LmroYAWy6ELXwZjrvpx1g6PnhAFYW7cQXHcMzs3e9JSRtt6TuvmODWBInqqGaNAig1
         OaJnVF61xJA3RJhfZYyaQxbEb1x8zt5y1Is6X25GhWnDEJmRiOHuem0Mjj86Shb3DjCG
         /IobZgtJkIUrczrXCKbjeGKXVmRjTv1ZnwmkZSpaLG20iHiTGM4xaoJaUdoj8fXgxl31
         wXjXD+uIeNXUzfpydsLJEcEB8pZMP3dhyEOmYgP42TQgLRKxp5VIiDUlZIui3OI0IniO
         ynDI3c6RbLM64nyut3Ekrp113r80eyo9eAklDbsKPZ35BsCBcRzvnVlqApSWDiDYMNPZ
         HblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
        fh=p+B2/H+rG+2LYS6rgajRqeMDp/DHeqgZ1mXNAffnbGM=;
        b=Zdv8dpfR7PsH5Ru0xk24a/ev9hhC8bINfvSDyPUsls4yLk5n+48rwcVQfqG5GxOiX1
         haPB4D39T6oEJJEvX8vZa4F+S3I8bQI4hJdEbhdFNXmPI4btJHQ2jG+y41efowBgs3de
         3YO/HmXQSdbJmKo9vqQ0LlakEGMgRjtLOuRgQJxqTsfGC51IR05G4L+8Lj5sk53Cx4hl
         eSU4xOP7HbCGT4yhnASPNccOD0IyByQmtneEKaoz87lySezMDEHpLkGZg2d84NZ7UwZX
         eeBC6pmCPduMDYaPVTVv66wZsGBR5S7F56d+UmzsSqq8PgmQ7hEB3U7KUO/LClxr0J52
         EOFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793053537; x=1793658337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
        b=WBXXhweSPlHVgMKR46msy9DuFxjt4NkW3RbN8qAJ8/bRtsErIsRfs8F582jzOM4OyM
         RCX7EiVyrNJckcqsfBGnjUuxMAMi/VoGOiNUi886TrRjKiLkn1Lu1GwVm+vGMLPNUcP9
         UPAKYeFhIGXO2dgUfLcdBCkeWtPKirGHRp/UfBB2FvU6A5QCBSdzceOMfP02pKqJgo6/
         Kz0V88vnDaGuHlYcSPFxW+gq8AxSEZgoix18RLsfTmUzN/hJg22Daqn5lWipjjA3o0QJ
         1+6v6LY7Zz16zGCfiK6iRGuX/Aho9eNt/Sk9AgWNwH98LL3TLxp+3qDyeyKpP89OJk37
         WHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793053537; x=1793658337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGAzUHcm0sGgQA1n2QKAQBWci/eVii3nOBq4rFQatG4=;
        b=i+z9E/DNiwj5ymytSgCyvgoMa5/Ho/+Kf5Q0Q+cfMFOLZ2LP2Dq73P8ZaBebBPmPbD
         Wjx0DzXCTOhPBw5mKGM10fsiiRFA95+E5MSeluz9eKrjks61xkhqCOMe18yRq+07P8Vw
         1w7RXb8rTk70q4vyQGYUlOWXEhk7HUkna/fgmxbroZ9KYDEVuvgWZlFMfOKNEudxdaM/
         lWfGI1wgue2MYsRERrhpfWZ9umH0sbZce2wzgy7O8GlC/pFZcdIZfR0txvStS03EAYx7
         CaFpMCIoydh98LhpyBQtkslb6x7C5Sb3mq+oxiqR2lwtUlIugonTKFf8b/jHL8N3EtDg
         ExEA==
X-Forwarded-Encrypted: i=1; AKwUvByehgEhqtenNcnRN4FyrTr9IlihFaqlfXhKhdigIWTdZ6iPqi4ZCR5yHJqUr4TcjMrYsjpXb5g4NwBI8fjp@vger.kernel.org
X-Gm-Message-State: AFq9FYLnyYNGvJOgoSTXvPWd6FVE5aXiyGpJD5zSackVPsXgzPLmIvRQ
	xwrvP49eu33xAyR82VHQe4X7kFeJGZrEauDX8o08Ta2JcR81yJVdi+BHOlXj9AiVqZkDWwIYrD+
	wsW2x/tFtbmFiQ5rosmui+LBpnEcZE3s=
X-Gm-Gg: AYBFou3iYJ0QcbH8lzWkGAiKz/sGonyymk7k1qh6v3djbaEUARr4lZWl67ShsQ/XwBo
	Sqg3zkmwnIkQXHrFmQduqVLW+KJae4Ml4l1rehg8UNOfm3uv9YuQZYGjvdU7COKcJbU/uvssuHU
	5i10HYCXzADPmO09y0AdstpF+aberq02E59Y4zjmEKVa9+mj108rUB6MUbPyABBqc6yGkNNUoJW
	qdz2UMSe7zwbb84LCwpn8GdcrtfX5YpMMLRzqbSJwqVq/0yIHUZOVzt4cq+qspZVSv1/xXRZaPZ
	nak9NL601XFjJ9Pd1PvTOUp5yZp+frAJFvNrCAQ8aEzQ9QKVEKzKA9e+O7DjFBdVDQeqqF5IxUV
	XeBswDTOmz2ejUzp3oLsyPQMiTglKsLwcSA7jyOOLSDhd62B1t+pj6vfK1kSkho33KhwqkbMb4o
	KP2ZRjmI8GWQ0zq1gGmhev6EmgAmFkkb5PC+c+
X-Received: by 2002:a05:690e:12c6:b0:679:ac3:9752 with SMTP id
 956f58d0204a3-67a4519489cmr5899753d50.13.1793053536512; Mon, 26 Oct 2026
 15:25:36 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com> <sashiko-outbox-170731@kernel.org>
In-Reply-To: <sashiko-outbox-170731@kernel.org>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 16:25:09 -0600
X-Gm-Features: AclHuK8oPmCxBxu3r6O0jmjf6VGp1ZvogtAuE50408WWPep9paf2BtUZbw8FvSg
Message-ID: <CAJfuBxysCwTo9PZpgvjz+=ciTAAmJtOBAbE55_D_yhk+XuvCFw@mail.gmail.com>
Subject: Re: [PATCH v12 32/40] docs/dyndbg: add classmap info to howto
To: sashiko-reviews@lists.linux.dev
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Low] docs/dyndbg: incorrect signature for DYNAMIC_DEBUG_CLASSMAP_PARAM
> - [Low] docs/dyndbg: commit message count mismatch for API macros
> --
>
> commit 28be193f6b722396acbf0216c1b36e74ba099d0b
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> docs/dyndbg: add classmap info to howto
>
> Describes the dynamic debug classmaps API and macro usage in the howto
> documentation.
>
> > Describe the 3 API macros providing dynamic_debug's classmaps
> >
> > DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
> > DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
> > DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
> > DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug
>
> [Severity: Low]
> This isn't a bug, but the commit message states it will describe 3 API ma=
cros
> while actually listing and describing 4 of them. Should this count be upd=
ated
> to match the list?
>
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index a8962ab22aaf0..f5b1470a4b881 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> [ ... ]
> > +Dynamic Debug Classmap API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this map=
s
> > +classnames (a list of strings) onto class-ids consecutively, starting
> > +at _base.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> > +call this to refer to the var _DEFINEd elsewhere (and exported).
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
> > +maps/exposes bits 0..N as class-names.
>
> [Severity: Low]
> Does DYNAMIC_DEBUG_CLASSMAP_PARAM only take one argument here?
>
> The kernel macro defined in include/linux/dynamic_debug.h requires three
> arguments: _name, _var, and _flags. Could this discrepancy mislead develo=
pers
> attempting to use the API?
>

fixed in v13

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-=
part2-clean-v12-0-3c8cc5725def@gmail.com?part=3D32
