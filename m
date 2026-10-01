Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8929B799
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895235; cv=pass; b=QpFfmONVhRopCr2ptVYhlOkAjt734MuZk3V9nGtcqnsp+Z1mCR+ouvZCD9NuOv+Ox58rli8O1Lt+i745n2h1m0GFMInyMM49wuVZis+gk6nIaio0iuscM2AnTBYaGHdOoWcfwpdEA1uwKed/TlCIenh2BBUPVKiqcAl/hsTd1Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895235; c=relaxed/simple;
	bh=9WU6gk8eX4Rgb9wpGURVmjH7c1vwFJ+Sl5X4ljE9SyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhWugNnPyGUGyH0eMau2ifN+ydV8upzcCrhlZU3VKog7r5b841lADA/FWSVuNOlHPkcCklRXQT7qKX+TfBkFehxRMJ0ZPcvugekKpt4MUlt+K4LHCraYKuqqKolDgOQc+b07CFthnsxCLpX72oun/LYtxunjCQuaRB4K/6yJRXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnwP/OFo; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnwP/OFo"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66f7a9afe43so6193432d50.1
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 15:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790895232; cv=none;
        d=google.com; s=arc-20260327;
        b=EoD0WEuzz4c639ynSDuznuFdsK/Hk2kDU+4b7VYwoRbdd4v1iY4U8ts3JpcPY7ZU3o
         /CDBdh1Jo8AU4Mph1WO4WVPxfX6JS2yZlMFSx01kQwHWwf03xLOs5KNzr2bVOwDVohmB
         lzCXk8ZfY8CmQkSmF0CTpfNy3hiVqKj+U9MKJiHwFVVdMr2HD0omfJtU4SDoCVqCW/oW
         JeUmLOZDLir9jNDiyAJd4Q5g7mqhFKY/83iuX54ixsT0KzcvfNxD4DkAUH8HycvMAQRZ
         GcDV4XmZHYMquveKdl0tCHF7Iqzr5rLEiDkfwkhb6fOx3RM5id4H+J4vvF7IbQTX+eX5
         bc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
        fh=Rr3QhJkBeovmLd9zVznyZRVT1mV4H/MELdbXVPpPqu0=;
        b=aXlnr/sYxObMhMV31/q+JHPW9iwmrBTSTLyQqZyooz2VHqHG1+bvoUEIOoXPvHu1aJ
         S+nVRUM9tHxGfhUi2x3f9or1zJgqx2UfIz1/smowgGbtAmTGDzuiRZ5Wjn6YW/HBYk0N
         v7KkITITppeyZ7E2HF8RFJXtu1GQ2LnIYawgXclgrifkxYTvrYDSObUrCczeJW8Oav/s
         46C4zqenoyuaIRN+hbv7Qf+UA4IegjnkjX8yyPIJyE7BjKl4tENhb0q8QNsaDQEeFY8M
         C7vU3h/mG6xghEaAsPkb1YVy0Pi1U62iZCzUhXG8PUI4ktkwNWf5XMgV3/eZVSK3KV5G
         udDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790895232; x=1791500032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
        b=ZnwP/OFomGoS544V6g6964xH7OTAHk+gDWea3g3Z3zgVJVcWOd5VmUpvwEOm57hD+b
         iNzEQ8dEkY7ilSREet5rvOs5l9RqzoFl/ASt7TEwkKsD1NTHNwWWG70MYe9arM7tZQH3
         p0rv7hnGnpofWUVOLEQvb8BBSY5wVVmGx8IpNTaQKQCDUOtFqQnW+Xb777aClBFNGpVL
         QbmeVZros6qFV2MaMcRYdpmfWfAzghGYTcw+54B8D6VQXNwPdg6NzjTrz813jO6m/sn1
         sdi+mi9TfO6yBK8XkR0/SbfDxDJYKUo33B5rfNdwg84A7PbwH8pryQVXJs7wCw8zz3ts
         6ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895232; x=1791500032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBYFdlPzVVihY84Cq15ZaQjohkF0LhdMTg9utDLtVGs=;
        b=WNXTiMrYCKivTB2FEe/3GMNKHPU8rlI3D4qOMiX485FxbWv6SuMr5kYKTRcNN+L/dU
         Hu6uMGeVYa3MvbymyuaUTx02lmAfXQilRpSKr6cXhKI8y/KVTHTZwvXWScrwCOfDQNRL
         YwzWxcp5OIjeOdf28kUWyuh+9hnlW41QqjZHW/DHU6Y/lqzx8pK5pee7qCguNjeDXcuK
         GggzbCCkTGFL81XEVKCa1+h1IiVO9Af7WVDPuttCuX18X6YNDJ7vuv3lAmcTPYVDn5xP
         GoiZ3B5wBx6YXXMiTlXuC9aTa3cO+aLSGhrBbSZTeHIqrt8e0ZlzM3+mhbG9dRDsbT1X
         1LVA==
X-Forwarded-Encrypted: i=1; AKwUvByNV/s0Aqxi4RsBRXUUMSAeMYl+8VzAEEeBt1KEvARvKMp3Iu2AeV32G4JgBsct7Vn+Udwyrf787jO6Z8W8@vger.kernel.org
X-Gm-Message-State: AFq9FYLvOhnPq/u1muq7GdkUrF+EaiulcFefAjZG8PBZTcliAUxpGXkG
	Njq79H1pSIuOsoADDqOG6LB21GuVVWJAf8/VIUsN8youFUsgR/h/kIyL9Wfl6ZO0xaZ49LZA4cF
	18oMYJxXkEMhdC0NASg9cWbDNfjQ5fOA=
X-Gm-Gg: AYBFou1GONYj9GSNTPRIl0nb4ktRpAPUL9pjvNZwZKp0Vbmd2ezNbm9S8z4SCmOMm4Z
	3J/FzCNOmx4aYEduAonZhc6gAL8Wkmi4boNA6+tl2OYbmjyloQ2qwElmLZaAJ9NY+UEyMSFzXsb
	LFTA4eOE1umA2dR6Hx1JB5JBYGzDToQkFcehC0w6K4ie4rj14CJfXcoR+bTxDAMkyeugO4CVFri
	TZZsdm1w4iSdDIn/xPu45sc9LUhPo44ZjjL5wtvK4/iugyrin28CwEIAnK/QJTSGbSDWHPAIb72
	Y+5A78P8tMltOnVts5Kcl1paysWrwjLGUfq8lXnG6/uaAQCXk6n0OB5lex7UrV+FjTtSBcel1nL
	mmjJ4otrWiyqck8NbUKr/itHLjQXe6YKeeJl5dGBx0NzX
X-Received: by 2002:a05:690e:1c08:b0:676:87c6:4f71 with SMTP id
 956f58d0204a3-677ac165db5mr389082d50.99.1790895231491; Thu, 01 Oct 2026
 15:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-23-9b6c217fdf2f@gmail.com> <20260923224940.ABEB51F00893@smtp.kernel.org>
In-Reply-To: <20260923224940.ABEB51F00893@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:53:25 -0600
X-Gm-Features: AclHuK89upHDiixXSE95YCeG6kGs9RvurvEycW_YR863IjXCz2W8iVCgqdQxxeI
Message-ID: <CAJfuBxzPMjqAsnqGqEESjZCfz=nmFGiOj6vFZby0kpAdFnNEFg@mail.gmail.com>
Subject: Re: [PATCH v11 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits allows stale modu=
le settings
> - [Low] dyndbg: incompatible pointer type in module section load
> --
>
> commit 0e12bed35baa8c038def6b06ffc95416176ee997
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-serv=
er
> model using DEFINE and USE macros. It resolves boot-time parameter
> propagation failures by establishing a robust reference linkage. At modul=
e
> load time, dyndbg now scans and resolves parent classmap references.
>
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> [ ... ]
> > @@ -2791,6 +2791,9 @@ static int find_module_sections(struct module *mo=
d, struct load_info *info)
> >       mod->dyndbg_info.maps.start =3D section_objs(info, "__dyndbg_clas=
s_maps",
> >                                                  sizeof(*mod->dyndbg_in=
fo.maps.start),
> >                                                  &mod->dyndbg_info.maps=
.len);
> > +     mod->dyndbg_info.users.start =3D section_objs(info, "__dyndbg_cla=
ss_users",
> > +                                                sizeof(*mod->dyndbg_in=
fo.users.start),
> > +                                                &mod->dyndbg_info.user=
s.len);
>
> [Severity: Low]
> The len field in struct _ddebug_class_users is declared as a signed int, =
but
> section_objs() expects an unsigned int pointer for its num parameter. Cou=
ld
> passing &mod->dyndbg_info.users.len here trigger an incompatible pointer
> type compiler warning and result in a build error under standard
> configurations?
>

fixed for v12




> [ ... ]
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +static void ddebug_sync_classbits(const struct kernel_param *kp, const=
 char *modname)
> > +{
> > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > +     u32 val, new_bits;
> > +
> > +     if (!dcp || !dcp->map)
> > +             return;
> > +
> > +     switch (dcp->map->map_type) {
> > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > +             val =3D READ_ONCE(*dcp->bits);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
>
> [Severity: Medium]
> Because dcp->bits is read locklessly via READ_ONCE() before
> ddebug_apply_class_bitmap() takes ddebug_lock, is there a race condition
> here?
>
> If a user concurrently writes to the corresponding sysfs parameter, the s=
ysfs
> thread will update existing modules under the lock, release it, and then
> update the parameter value.
>
> If a concurrent module load thread executing ddebug_sync_classbits() read=
s
> the old parameter value right before the sysfs thread writes the new valu=
e,
> and then acquires the lock to apply the settings:
>
> sysfs thread:
> param_set_dyndbg_module_classes()
>     mutex_lock(&ddebug_lock);
>     // updates existing modules
>     mutex_unlock(&ddebug_lock);
>
> Module load thread in ddebug_sync_classbits():
>     val =3D READ_ONCE(*dcp->bits); // reads old stale value
>
> sysfs thread:
>     *dcp->bits =3D new_value;
>
> Module load thread in ddebug_sync_classbits():
>     ddebug_apply_class_bitmap(...)
>         mutex_lock(&ddebug_lock);
>         // applies stale value
>
> Would the newly loading module miss the concurrent sysfs update and
> initialize with stale debug class settings?
>

Holding ddebug_lock during the READ_ONCE() in ddebug_sync_classbits()
would deadlock against ddebug_change(), which acquires ddebug_lock to
iterate ddebug_tables and toggle descriptor flags.

ddebug_add_module() publishes dt to ddebug_tables under ddebug_lock
before calling ddebug_sync_classbits(). Because ddebug_change()
acquires ddebug_lock while walking ddebug_tables, any concurrent sysfs
write either completes before publication (so ddebug_sync_classbits()
reads the new value) or executes after publication (so ddebug_change()
finds and updates the new module directly).



> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D23
