Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CC37D12D
	for <linux-modules@vger.kernel.org>; Fri,  6 Mar 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787252; cv=pass; b=abUrNyy8vbITIOeUdbWgt6I4fYxAt7fVZlgDZxf9rjr0Apv+tkYru/KihdOcMiKhVnkmhi1bLeNbaettR2YqmHW5fIiwWxJ398xL6IFIe5VN4ABdQWOoa2pokhJpKgX4KlSl++8bBG0Q9hJN1UrP7pcgK5JfVlmxZwPSH510PZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787252; c=relaxed/simple;
	bh=rdGRpEUaht6MYf6o9RXZIZscTi3HqoGwM8V5j3py2CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaB7ttCgP0of0WZwr4EPmNPict/niajU08ZFo06xY6buPGPw2VXNoK+PZQf/d7Lj2H73N+si46LezqEt7nWbaMnJ4U28PfZKCIpx0ZRHk2QlhKRDIcFXJ2f6P2X8D9WriE/epvRqpZsuJ4SS+iEXdRv4p2p7537Dlur0tKeXK6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED4NOUce; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED4NOUce"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so7748652d50.3
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 00:54:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787249; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/Uv0bk7YfDTviEc18N53sBJyPUnfz9+W//lv9r/XwVY/AuC/ffxynWTyVImKVIbHw
         jll/phAcJCo5rPdmOmqr91gIec/J0bTb/tGAblSx+R6uLTHu14IFgaTgjyTJ9vSy2vib
         ZZX2pSKfVBxnzZnbrEtVUv6qJe68YFH/c/tHN9bV/B6Ofbs8AhJZrmdUTGYYHUPOwXQD
         j8/Llgrrx04DeBbcdOey6tA/Ge/fqwOn5c8D2z3Jn60ipDVSzDGxQkspXAd4thi4IM8X
         Ad8Vv5CojrqXpc+X9fK4PiJuT5ehP+qqNnfPnkp8p1fpwqXOMVEN/YN6nRbsU0VZW8xs
         akPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aw8D4Y5kt7NM4MjYbrQrX2vFoTbmx8s3dgBNZzvOJ8I=;
        fh=TgCZdIziI5/eAO64K0/bKEoivLG5DBrzdUbsxM1N4fM=;
        b=PTNiTEU4wKtDCQwv4Ac4ydVy6QRGfWoswayb0684jxP0/bbG3ovYyCp8JkPW3iQ9eT
         GsApfnd/ZYAWScZQx+Dnn2KuGS5eCNSwdm+Cxx1AZ3zA9pADPpqZM5jsF8A4+a/Ky259
         56WFrv2LGQg7+XGTbBI4MgxS+YI29+lQqEDO/LpZ9D+U35nyQbUp70D2UFNbChOeXVY0
         mN10OSR4WEzA4dxXjfSdB9gAy3pMeK6AXG4qyEZErLdoTCJKx6WxMJAxhJf6zsd6TcJN
         odT9tHVK8Bs330xchpphdyDY7rt2xe/9bOwxw8Vr9KFK9visc+NCg+fwZ5fSipvU4/bp
         /iWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772787249; x=1773392049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw8D4Y5kt7NM4MjYbrQrX2vFoTbmx8s3dgBNZzvOJ8I=;
        b=ED4NOUcevo0TIgGlr8lDdkbWaxP2jc30ZnZAGA4YShNDmfS5HiztAoEm3Ipmhrc7VP
         fQWRBmEkaOeZkRW6fLfxciXF5pEexhty7XBxqBl3qlN3xyoZDWBojzpC7500YtWt9OSk
         22tOhBYeNpeoi6v1DwIF8/+IXp4dawBIFIYvcAoy3/1urlo0uxKKf7e1dRxGGBHtFClN
         klBBNGT32BzMW2ZSyj9RQM5J/i3uS78HLRZ644NWWk3ptDDinLGUPdaEFs4D0kIgIvdt
         93se3zP12Oqa9nr8V8IcSIt3suMkaTYNa8RqpXqVcyIuBQFawxzRRUMFJVENws+hBSYH
         qSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787249; x=1773392049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw8D4Y5kt7NM4MjYbrQrX2vFoTbmx8s3dgBNZzvOJ8I=;
        b=fz9UbwXBVyiJT2PPs2UyY/ZHLb7ZVIJYJrAcCoC6c5sQ9TJJ/sm5HTv0+1r9Z9GwAx
         lH0FHIteh1mF7QIx118C+k5RJAwSm6liw9gTiCpLPFuKv8Vidvmz4c/xWWCuNf1gQt3+
         g8xzHcdV6BinmzeyjngfYq7ikCUm2253urzY+s+RC67Olj+C4BIDp763g7D9zIYi60S+
         GXV145B9JKYa7qhT9P+lAOiScIL4wOqNgCQ9YsgfMbsMIdlK8aMPIV/O5ON0kKRy6VMG
         lz5u7qPlKQDkgCmWiKIqBeUaONtJIgcQhC8dBu83FPE/TJij9Wfao1wgoD3UGHXvoUxs
         4S6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXtRlh1304KS9YSmSiKNdJxnwliQzj4dfw9gaosXAN4VjwM7eq28mAyBDczf2I4SE3qRaCUZoMIcABoT2u@vger.kernel.org
X-Gm-Message-State: AOJu0YzncJhXRbttv0+C2dPVDGKltg3bKGdP+gpNxj9/ujU0oIC3GGnA
	1FgDIKbJ0t9gj7KUnIOAqjxSaT+LKe+2L5yYFRg7e9B/Gf8jhs9DseKLZ5yT3ROeWY0lkSUqQxH
	Mgcmi/edR2txF2lf/KiOG4b/hW1Fq5FhoKvSJ
X-Gm-Gg: ATEYQzw1F9IUwnqefwih068j3FtRss+tYF3oSFGERj1xEm+SZgRTIHkFIe+EanNDYlS
	0lz2sc5DIWS9SFXCzcEj4v9NghrSVelTe6iTOEUVNaP3t+A6lzCy8U28yPdk/+4lJe3TDK8t9p6
	ARRCG3V+88AuiE8KoeFi3J5M5Nab2ga18WjIP2/aJc2vSozF2UhP6TmxkNVAsclThoIlAUuLYsI
	7jY8nQrBJFeQgCeFi25f/Gm/YS7TQ3pW6SGuZttyjhWQO74nwyU1V7X/Sufvw2EMAxyxJ+u+mc0
	YlBV/rEGrg0ojBg/
X-Received: by 2002:a05:690e:11c6:b0:64c:a815:511b with SMTP id
 956f58d0204a3-64d1408d74bmr1254215d50.3.1772787249430; Fri, 06 Mar 2026
 00:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231094004.37851-1-laoar.shao@gmail.com> <20260305234344.GA788042@google.com>
In-Reply-To: <20260305234344.GA788042@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 16:53:32 +0800
X-Gm-Features: AaiRm52YuDGMTei2U-duixAZc3ezplg-GrnVYEYAkJn6ERpnkoGCdzljOtRl1b8
Message-ID: <CALOAHbAaN7qYmyTLc=oNRbnpHCiac_JTfCBVYEqVZDfDcW0Nvg@mail.gmail.com>
Subject: Re: [PATCH v2] module: print version for external modules in print_modules()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:43=E2=80=AFAM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> On Wed, Dec 31, 2025 at 05:40:04PM +0800, Yafang Shao wrote:
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3901,7 +3901,11 @@ void print_modules(void)
> >       list_for_each_entry_rcu(mod, &modules, list) {
> >               if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >                       continue;
> > -             pr_cont(" %s%s", mod->name, module_flags(mod, buf, true))=
;
> > +             pr_cont(" %s", mod->name);
> > +             /* Only append version for out-of-tree modules */
> > +             if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->tain=
ts))
> > +                     pr_cont("-%s", mod->version);
> > +             pr_cont("%s", module_flags(mod, buf, true));
>
> On second thought, is using mod->version here safe? We release the
> memory for mod->version in:
>
>   free_module
>     -> mod_sysfs_teardown
>     -> module_remove_modinfo_attrs
>     -> attr->free =3D free_modinfo_version
>
> And this happens before the module is removed from the
> list. Couldn't there be a race condition where we read a non-NULL
> mod->version here, but the buffer is being concurrently released
> by another core that's unloading the module, resulting in a
> use-after-free in the pr_cont call?

You're right. This can happen.

>
> In order to do this safely, we should presumably drop the attr->free
> call from module_remove_modinfo_attrs and release the attributes
> only after the synchronize_rcu call in free_module (there's already
> free_modinfo we can use), so mod->version is valid for the entire
> time the module is on the list.
>
> Thoughts?

It looks like this could work. I'll analyze it further=E2=80=94thanks for t=
he
suggestion.

--=20
Regards
Yafang
