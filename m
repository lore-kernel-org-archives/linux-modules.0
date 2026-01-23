Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296992EF66E
	for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769211277; cv=pass; b=iscw9G3xk1me4XCGLjb5r26UxelOQCEhgXo9Fr5+YY07fOyNLbH2/CHP6jYaU/oocwBkbyCIz6XPVAE0L89aL3aQya9SF97lPADKMRYPKhYExUiRu2zkoMJa9g8vsLbm/IU+IGNo2vkVbNc1uMAlxbZbH5r1tudXZNmvwgppFls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769211277; c=relaxed/simple;
	bh=dgHnnoYgHT35puT+S3A/6NpCEOGxPEIOwEcbI46KVLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP44eK45+4k2liFEVwQ2Itpcon6ay4v3OZzAK+SoN2DX4hoBbHN5B0Up2joJwrkZbY+3ll47TN1k5as8NgR2b8eF5B5IUc4Jj9jPVhi4FL3ppg6rCDr3wcH3aX6rtzZGFRiORhaqi36YT/mJtYLByegrwgTXhtmoi/DBzGqxYQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipHMzi04; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipHMzi04"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6496804204cso51906d50.3
        for <linux-modules@vger.kernel.org>; Fri, 23 Jan 2026 15:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769211263; cv=none;
        d=google.com; s=arc-20240605;
        b=Do3ejhy6ITPdBsNl+JyHdefKLoenBCB+lQph6iZL8Yu9S64aMps5JnEIuW/vOF+t5S
         Qzdvh5BaPABceg1SYH1sdLx4mA5U9Q/0OK4YgUxyUID8Nd6CTxHb4ADUqPv1psBEiY+V
         JgcpbKRcmqsypCkhn5gxTeQhoiW7u0cV4g1XL6iCZ6ZfttWqeZfOzuHbUtDQFgn0AHxe
         4mIixamvFAqtF07IEZUOqvkRT/oRU19SmEV7B6FD0N8VYZrQwTuTVE6GV9sJp2HUDVG1
         p9R8K0qfxtRCdPTXwX4Aa32P4YMrj2zY9oeWQy4E5tapvGirKqTTpcFaVBYFD2hrPYJN
         MZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHu4tU6bE2Kw2zZ3G3dJF8V7Cm5hcC6PjK+qVhgv4UA=;
        fh=VTVJOevRZ6XAeBzNSBkKIOtwOvuBXhLhDGF5x4iqzXo=;
        b=C0ns5GZnt5QDd3vpa67CRGei/89o8ffjTiFKz4x+9xg1tCHCZ7J3PPhdSPs5GClFcq
         8lzJ8GZwiKequxDou5Vy4kHKK46IUR/Qm2ZTjolR2sO0jEK/6cxoDjZM8eP2q+XNMTQ9
         CPrEk60+aOjW13NEuIaEREdKmjx5q/z9YGjTLU/3je3hYWwDlc3MxhUNu/AucUoxn3MK
         PI08Ro4ONbhkxRwrEzvmj5wL8hA0nUH6vDQ6SpfHmmUD4wGvRom5M06vWCkhD7gzcSnD
         Qps8nX4Nxr7pq+5zMH/+pm8RxZrgHACZV/ussiMsviMaHEUOG+40rVpJ2pEW5J4XqQY9
         68cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769211263; x=1769816063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHu4tU6bE2Kw2zZ3G3dJF8V7Cm5hcC6PjK+qVhgv4UA=;
        b=ipHMzi04LwpWvpESzuc6J8yWH/nMNGoeH+aIF3+ShdunZWp7v8Kwk4jzPJ/tZkay19
         kJRT5IVlAZjT2I9sc5V7Bl3OMn6yimnDM6B657DoGt5D5F7MKEZcLFFldR3bXVjwWf7w
         tWsKhhDfsoZWJlKhJcrERwneTQ2X1jo83wW9Y1jEX5Mbh5YU6DGe7lMhzrHlOYbcFKdJ
         k5VwbsUJnr++uTK1HPpN9kSFUr5pkm8zF/BvSrUBYWINZDUus0heaS4QO9jML9DKy47e
         W3eanXQPuPgH7oK/KNYASYeBDg7GDHGQ26icYGnUdhR7zzNo4AWhAKlDcAZECKbXSuth
         Hk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769211263; x=1769816063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHu4tU6bE2Kw2zZ3G3dJF8V7Cm5hcC6PjK+qVhgv4UA=;
        b=kxb+0Y8qifbZ0kcOvdYE0ftdoqpQ7Mu0x4c9tgAl0ozdk6qaDbBWYjYsAlGUClszl7
         ch+0UHfsOP293b0sZ34BFhcuXDQfk47/CtxM1+CgBlsVkFYWZZxgARDaNpno27JlkoU4
         LxQcrZvgVNW9LPnQCtQdvQJVxc4pVRrrL+DBZ32f96kJtBySI2TDMtk44zTU4GmD+yuM
         0xMhLdSSS4hb3wE438tnRkI3Zklf8pOj0MczQGLmug/HBDeMtVihJjW519jITJinfw8U
         9ANvEKZr3wnfA2dAcRszSmGH9gehEyWq78wDPA1ReC9d37ZlcgFWuPc8PdkPKxfDUi39
         JVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUviVRCpaF4N4jc6dHHuOPoCsz9JUE0BNnRX9/mulIRniVl1asr5GttXQ+GZTKOaI2T383qo8YDetoV/5VN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/+QcwjMRc7nuaDrh+0ux8Hh3fXwRDfaoDGH9qV7QiTngqFko
	0kt9nuYdEdVDq7tTn85nMK76c9hvuWVb7u5prqF4PRQjVyy6E6EtcxOb9P/cdo2TI2prftD+8YW
	+xChsHSrCLMD2D8PuLyVynJ5kKOzhoFE=
X-Gm-Gg: AZuq6aLzbev9XOvMCRPM5D5A2H50qlQGWt6PK71t1Gu4k1w2nGVPq5x60onzgcSpXyS
	yGZcuN0y3jbU5OL3BZvcHWXXKZr/M5/KAJGJ/XbLC9PylU+uFlTSTfSpACYNPpCAviybGpb0DJr
	F7sIO0Dq/f2UhNFDoo0LPSVoimSUY1YOGPKOMegU6OMV5FdI0Iaf5uum3buy4sxW/2IQ2wyg8lM
	CGqNyF5wIP1zuv69zEj0e2HuKzZPEBKEcakqSnvp6dtRPWAtB6NBSuKZW8QNZlg1PVEm73w8Jep
	+do=
X-Received: by 2002:a53:ac95:0:b0:642:eb49:7154 with SMTP id
 956f58d0204a3-6496125f1c4mr2274419d50.70.1769211263270; Fri, 23 Jan 2026
 15:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122234621.3403276-1-jim.cromie@gmail.com>
 <198d1ca0-031f-459c-89bd-6d438a84fcb9@suse.com> <aXNNpCl2lKb9YXJN@macos>
In-Reply-To: <aXNNpCl2lKb9YXJN@macos>
From: jim.cromie@gmail.com
Date: Fri, 23 Jan 2026 16:33:57 -0700
X-Gm-Features: AZwV_Qid7gVo3Vz0hSdbkto_vy_mXpj5XdjKtAH7T39B1DfccSTKkVt1sOrNUIY
Message-ID: <CAJfuBxxLOi0tB=-ZuWeO1aw3CEQHcWr5CbaSf9u6PyvzcZNuqw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to
 struct module
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 3:32=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> On 2026-01-23 10:36, Petr Pavlu wrote:
> > On 1/23/26 12:46 AM, Jim Cromie wrote:
> > > "modprobe foo" currently does strcmp on the name, this can be improve=
d.
> > >
> > > So this commit:
> > >
> > > 1. adds name_crc to struct module
> > > 2. modpost.c computes the value and
> > > 3. outputs it for "modinfo foo" to see/use.
> > >
> > > 4. adds hotpath to find_module_all()
> > >    this uses name_crc to do quick "name-check"
> > >    falls back to strcmp only to guard against collisions.
> > >
> > > This should significantly reduce modprobe workload, and shorten modul=
e
> > > load-time.
> > >
> > > Since it alters struct module, its binary incompatible. This means:
> > >
> > > 1. RFC for its wide "blast radius".
> > > 2. suitable for major version bump *only*
> > >
> > > 3. it opens door for further struct module reorg, to:
> > >    a. segregate fields by "temperature"
> > >    b. pack out paholes.
> > >    c. improve cache locality (by reordering coldest on bottom)
> > >       name should be cold now.
> > >       bikeshedding is appropriate here.
> > >
> > > NB: this isn't a substitute for CONFIG_MODULE_SIG.
> > > It reimplements crc_le(), doesn't reuse kernel's version.
> > >
> > > CC: Luis Chamberlain <mcgrof@kernel.org>
> > > CC: Petr Pavlu <petr.pavlu@suse.com>
> > > CC: Daniel Gomez <da.gomez@kernel.org>
> > > CC: Sami Tolvanen <samitolvanen@google.com>
> > > CC: Aaron Tomlin <atomlin@atomlin.com>
> > > CC: linux-modules@vger.kernel.org
> > >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > >
> > >  '#' will be ignored, and an empty message aborts the commit.
> >
> > This patch looks as if it were generated by AI. If so, please avoid
> > sending such changes. Otherwise, the commit description should explain
>
> FYI, this is a process already documented. You can check out what maintai=
ners
> expect from contributions and possible guidelines:
>
> https://lore.kernel.org/all/20260119200418.89541-1-dave.hansen@linux.inte=
l.com/

Thanks, from LWN, I knew the topic was being discussed, but I was
unaware of its resolution.

FTR, I did argue with the AI, it gave me the crc_le() fn, which let me
proceed and test the patch.
