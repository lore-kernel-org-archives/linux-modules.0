Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8826B777
	for <linux-modules@vger.kernel.org>; Sun,  8 Mar 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772979278; cv=pass; b=VzcEQ9M0lgPrdtJ6VGkq7hLBOpZkjI9xrbpgGWpYBrOwZbP+KQ+pjKmdfh0q/4tvhRmG9i2wxgI6Ltzm5M3+3xh3OHtxThd5TFJfdjkE3UbhPvzIpcN9NuytK2AglvSkAHVvSS7u44IMrltFHZq+OaTVMWNvtQA4ix1aCO/X+Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772979278; c=relaxed/simple;
	bh=04Pdk0NM4P+LF80r4KSUSkjBilo6BsdXPtk2ljAJftg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqxOrYnwy3+ahcatRXTfQG4E2802ZnW9Wzih3nI98IgQLygiDqUKCYRXFt4I+dni+3RXJUi1gilN0X325A05FEYh2U72EG+PvKili37wJID6yK3hf8CVSbwFxS/7EYVPLVhCnXxOQLI5ufXVtbhw3LbQy29vSC2a2GLT7bjsmhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3xbLG+C; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3xbLG+C"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so10484611d50.0
        for <linux-modules@vger.kernel.org>; Sun, 08 Mar 2026 07:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772979276; cv=none;
        d=google.com; s=arc-20240605;
        b=VgcVrkm08jHgU6ibDENkQlP8b/tYbQMed02azvvwEE/pF/KwfdwpCmvuV4CwX/mb/b
         Wi9TTGPCE3wxcJcOFHli1KpskZ9qAE9H8FiL56S8ORcYgMxrArVXV4nBz5Xz87ckZqL0
         js1jLbiahvXmAaGxUiAcfOSY1RY4eTJPucHmC/Hq6ErYJrwt8bYKoe8+bW57LIBslXAJ
         HDHWSq9VUcevBZPAU7vnKAIzGHEYjLuoltA+PKdxZsCO3gbnqITzpGzSlWMnTBfXbEl7
         45rssQnYV1UzQNxkzBmStrS5MnMLWCuovHhZz6X9afnaAaDveQXUGq872ZPWy+syWFav
         0LSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxs5aKR0De8xRmljQCzHD/eSc7IuPRZZkVJfHr39BkQ=;
        fh=HZjyULRY1HqmY5JyuTAXvtq1qqeCUxmzEndTqEjr010=;
        b=LmaodM322f1stpErJXsm0szBcQfIzRnB8glav31MzZsGxWXSvaoF6V229a+0cAMk9k
         KDK8LH+jVftCm4MjhQ6YyL2t4FQr/qy7QZFs78Zvqgk/Uh8bdxzu4KsiTb7TNjJok6IR
         +ZPYBtGpq4tGpUkVWhKzNYjiyhGeupM1SNDsplpJaSK+UX2nQFictQdZRBOVJcaozk9E
         slckvJwutkcglS+T2c7y6Cycu219ZzmJuLihEvjIkGp79tGHf5qjTcofJ6HD+k+HpFJ7
         4WDt2g8+PfElMMl3nt5aTjOvueJiQmB56Pz8174CFfEDnOmn8t+rT/X/IoD9BH6wyCf/
         /A1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772979276; x=1773584076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxs5aKR0De8xRmljQCzHD/eSc7IuPRZZkVJfHr39BkQ=;
        b=I3xbLG+CXjySLYJirPlHT23vWyW4FnmxcSMHCTwgUb19bdspjB4wUg2gHbWuEvBKyF
         x1lJ0QmrpbFCBGZXYdg6p00Bpg5K/Kcs2zCZZ7/vcDxQ95WrZe06vb/RIF3Hv4Jqnkp6
         Ps3lC4WuWUK6miDc1m0kw9ZWa5lUXgqASshf73+hyIgL2TPdz/jCN46vobhdnDf/MVQD
         PTNGsJM0dKQkpTjNAkwPhsoHtuqqFe6BwG1TrBmK06UQJBRyDPsTYTJdTtsbhtRIWqcH
         /jqjQS1z5uLyt4pEPfOJYACscGCLLqezKFn4RYrZici5BLXXIzLLcYNnX9QG90ztw5T/
         mYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772979276; x=1773584076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxs5aKR0De8xRmljQCzHD/eSc7IuPRZZkVJfHr39BkQ=;
        b=KblmqUoMLw6/T7aHz8/FMgKlooVhe+RkXaDK94VPcQtLYODnWmK1NLyFa+kBxtF8Yl
         XHmyRx2UClpOThf6lKYzmwYgbBFsw1J1QRwar6cgYBp40hPx0iGYMhddNktmgnMTtJFt
         o1nXPh+hiO9wjaOwdui47qeh6jEQyGysLB35Weht44RRZWcCwD3O23s/Qdr9M9sF3V14
         Xw+QyOkTl6e07x2vwqZa85BjapGrYsMe4vqGqMDOzn2Zxp7HteAlbg2KtAPPm595+GUx
         vBR3+lPQ2PByvCjlQ38lmNd2TvlWcSZqU+UZUXJQ/ZKG4fWM9CAKgCjiUwk++cksohK0
         Q5fA==
X-Forwarded-Encrypted: i=1; AJvYcCWiYvr1jPQ+fisnvsjBe/vDYbecKZDoec5dnpnK/r2ODCgrR944mKVqEH32ittF8NJY9IyV4kqrhOdP1yrw@vger.kernel.org
X-Gm-Message-State: AOJu0YxOj1Bhy3QYOivWb6e3gOEx9IfRsPDPzqHb2iPYm85K8fY4eTXK
	Ng8dms01LDhzmRZq8yKA2JZhcNYEkesluI4bpc4burJfSvrJnxUcYAFzTNAs+tg7Myc1isVGhgY
	Hka/+iTrkqJ+vbeMLt4Aj2ep8HCfSZZw=
X-Gm-Gg: ATEYQzzIFL/JH7IHMztmcjRreK/7AihYO3eogS/4KacwoIyndn4ZK6hRXdovyFatxh4
	KkY0sWUnL4QNjK5fhO53cU3VLQ8Blv8mORoOXYc2fb2PfVMl0miTpc311olGV6D19Qqlit5LZQc
	/XL0Q3ySQmrggYxLI5qh/Fj+m95bdy9gejs3MJm+W/cG1pwfG8R/+0irdDfddu/IhzLUYvIk/l0
	Xah2WSWVB4GIMIVpezBtYXn7yPxmw8biFEW6mp4u9L7ISHKQVPrkTzL0V2Q5ksvwpkU+opwsIya
	UvNDylRDfM67tJoRimk=
X-Received: by 2002:a05:690e:16d5:b0:64c:a1b9:ffa4 with SMTP id
 956f58d0204a3-64d140977d9mr5775796d50.4.1772979275970; Sun, 08 Mar 2026
 07:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231094004.37851-1-laoar.shao@gmail.com> <20260305234344.GA788042@google.com>
 <87a72531-5730-443d-8b6f-07ae9b8df6dc@suse.com>
In-Reply-To: <87a72531-5730-443d-8b6f-07ae9b8df6dc@suse.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 8 Mar 2026 22:14:00 +0800
X-Gm-Features: AaiRm52rpoHRNwzBvfZOulB54t5No0j0lp9MWDfDVDN973uAAFg-EC7G1VpgbZ8
Message-ID: <CALOAHbAB=ubQ8X6gRY_04UYVvmGA1tY49o5w8GV7Nh==Y3nveQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: print version for external modules in print_modules()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, mcgrof@kernel.org, da.gomez@kernel.org, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 6:10=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 3/6/26 12:43 AM, Sami Tolvanen wrote:
> > On Wed, Dec 31, 2025 at 05:40:04PM +0800, Yafang Shao wrote:
> >> --- a/kernel/module/main.c
> >> +++ b/kernel/module/main.c
> >> @@ -3901,7 +3901,11 @@ void print_modules(void)
> >>      list_for_each_entry_rcu(mod, &modules, list) {
> >>              if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >>                      continue;
> >> -            pr_cont(" %s%s", mod->name, module_flags(mod, buf, true))=
;
> >> +            pr_cont(" %s", mod->name);
> >> +            /* Only append version for out-of-tree modules */
> >> +            if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->tain=
ts))
> >> +                    pr_cont("-%s", mod->version);
> >> +            pr_cont("%s", module_flags(mod, buf, true));
> >
> > On second thought, is using mod->version here safe? We release the
> > memory for mod->version in:
> >
> >   free_module
> >     -> mod_sysfs_teardown
> >     -> module_remove_modinfo_attrs
> >     -> attr->free =3D free_modinfo_version
> >
> > And this happens before the module is removed from the
> > list. Couldn't there be a race condition where we read a non-NULL
> > mod->version here, but the buffer is being concurrently released
> > by another core that's unloading the module, resulting in a
> > use-after-free in the pr_cont call?
> >
> > In order to do this safely, we should presumably drop the attr->free
> > call from module_remove_modinfo_attrs and release the attributes
> > only after the synchronize_rcu call in free_module (there's already
> > free_modinfo we can use), so mod->version is valid for the entire
> > time the module is on the list.
>
> This looks reasonable to me as a simple fix.

I will send a fix for it first.

> I also noticed that
> setup_modinfo() with its attr->setup() calls is invoked unconditionally
> in kernel/module/main.c, while module_remove_modinfo_attrs() with
> attr->free() is present in kernel/module/sysfs.c, which is conditional
> on CONFIG_SYSFS. In the unlikely configuration where CONFIG_SYSFS=3Dn and
> CONFIG_MODULES=3Dy, this can result in a memory leak of module::version
> when a module is unloaded.
>
> In general, I think this could benefit from more cleanup in the future.
> Most of the code related to modinfo_attrs should be moved into
> kernel/module/sysfs.c.

Following the change suggested by Sami, the modinfo_attrs definition,
along with attr->free() and attr->setup(), remains in
kernel/module/main.c. Should any of these components be relocated to
kernel/module/sysfs.c?

> Since module::version is now used from
> print_modules(), which is part of the general module loader code, the
> initialization of the variable should be independent of all sysfs logic.
> Ideally, the sysfs code should only read module::version and no longer
> manage it.

After the above change, both the allocation and freeing of
module::version now reside in kernel/module/main.c. Is this
sufficient?

--=20
Regards
Yafang
