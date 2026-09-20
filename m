Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947F2D738F
	for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936005; cv=pass; b=WBg+6DXmq00hweSzKBwlJDg3VUwhLllJJ2/57CxT4qNbNEyU0/fhuKXTD4lKuC9C1kjzsRM02F+glTRuIGfU9W+fwzUIzwtipOQeVAz4xf0YNuQC8V0R2sOyKDwIG9GdCO64FNiVehsI2IusAu9rGO3T7zqrn7qDv3WDpq9Wwh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936005; c=relaxed/simple;
	bh=E2iEBO8dOpu0/0Lr+dW8J7NY49JLrf9mwt5f8hTpVW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpdMzunn6J7FPx0m8g22Gcq31FCKEYDTlimg+FClICr1sav7SbVSWTyryVnSz2gDyhOYm/PevzNDdOQ6nYiA54/pAObELtPF+NOQX6vlDlAHrpEyVnh28P0sVTEZ+PmisyLv2Cemvf2zjdLOKCYly//WZoiddBFhUmb888DKzVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTvbhEeC; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTvbhEeC"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so18196417b3.0
        for <linux-modules@vger.kernel.org>; Sun, 20 Sep 2026 13:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789936003; cv=none;
        d=google.com; s=arc-20260327;
        b=UumRUiHdjxvvHOLpWhjLCmKYzJc2/H4V0Uq6Mf7nF9V2bk10dkTiK5OiuaIhfLQOlv
         DeHPp25NPW/uUyY1SsbuinbaQ0bHGVDv2ku6j0iqEgfkmmiglgYoWl7OimET/kmWv5ak
         jX7EVtr5aj8raXa9fYiZ5E4/+dhRBbOky/+ld0Mesf/GFZgW7tKgZ5KO218hPv1b02o2
         9LbjXflOUfv2dB6EyNTZX6d/bG2EOjnFo/vsjBvCQy5HVeKOSQ6+d5DSZHl6OTl4VCX3
         2Qa/5NZxwsPdW1hG0JHrIGoczqKYKyBIpDt8EpWF5ZyChNVHOUmuWP0kXxa8ewNV7dH6
         LJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
        fh=cYTyLiD7YEGbmIMLgzI3TwFYd9DFSQ4+5Q6IJhlYE2I=;
        b=KupzUwOWu5GEYDwaYPGMefAnfbThieWqnKkgXyIKSJcJEbYRCcKm1a+gFli1Ea8cdB
         TOLjEc64q/bCkwlDctRcJjXvvcnihAcOHbKUHdwIKraDC9Fn01G4EBov+MLk0xK6WlWf
         lHUMrdkvT9rajZkrIbp5uzPqtX110mx5mBwGLcUxkqnmafedT3JjqG9mq0HDhQ1ta9ry
         PIRjYr6zhtS9vIcRIFVTJdNZ3ofydMjwSgnl1517ztgUALYzyj/aP3V+o/IjK+Uo13++
         7OCNieA/fVF9vy7sd+SQL30rAShav6+0rNMu8DbaileBGCMgDApHTzncXJMiGe/NfJMh
         bXYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789936003; x=1790540803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
        b=RTvbhEeCWGrb8Z4MVfWh791rWmhMqnBo5nDm+heTz5eo8uleeXl2TELVO68q9eC8fN
         zvON9FDuu+jJDlkFJY/5Y40GicWF4b4M31Ib8QhwjZJzSKLva59brTlazGFxx0/O7VC6
         CWoWKtgKRVwV5bWzo8/iMkttck5htpTx5ONU6UdrrPxe+K2dstGhlMSPZ94dH8IRWmh7
         l5G+DcqaMQPGchg3nD5Wb8maNMa3J4FcqiAn891DLhH1xJp0lTHC/XYNYWK4euz3UNkB
         v8R+4mW6P6IHi+C6MtHJW4l/Z45tsmI3wDLK2kG/EnZtoin8d6MkWdGMsfr5itjupurz
         s/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789936003; x=1790540803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5Inp0dUK9mWGDzU51sPdtRsOeEciT1UFPFVj3DOFnI=;
        b=kCG4c1SyFRX5JVsJiACMFXBKK4CMhoIPNRLNXKre0YiEvi9A2W/yRKjxC5mFxqYoLd
         OCreFVk5O8e20kdOyjkVRESybCUDmdWfN4nLLNzc4yzMVNbA43U9V4Zvpo0V/Oxhr8cS
         IzPZFCXGi/QcTeVOUiyywmxkXtptvptX7LpIP57ktKc/D5R7b/Rtg7FoCfgQMorzv5Lj
         6/mOjwlWkM+Fosd01f6Q0pxj2bttW0EJxhsU2SgqLD9AT40hgSn+ROq434ZHKVpfkC7b
         BUXbaJMlkS8vqPPnRKUQMNQ94wlb97C9kpLXdxQwIQK4qY8biZqPSoSDi8HqGzaSbAwq
         fYEA==
X-Forwarded-Encrypted: i=1; AKwUvByeRofGGunRz39qABDP9LqfO0l/KQWFRqM2KzuWivH3gwCaTnN/qzM0CCOxDXyxNtsWIssQCS46AHF4Wl44@vger.kernel.org
X-Gm-Message-State: AFuF++m7J7REWbg+UH+B9Fgy0tr9UC90K2I/qW3NGFKHyl2NRzuLG+JB
	r5wZSfuWKQtRUZC9tJ+lnUPSOWeSNvMJ4Ry1stoz3IhLlca9JNythTDIQ9QpL780cAr40hQnGPo
	KwDAf4KLRSeC35wYKtU/8qTYKFEboUXwKW3Z2
X-Gm-Gg: AYBFou3LFT1i6rhd6R7CYihR2Aq2NIHbTs5HQjxEBtEJ1jcTpWm218B0xcbfyNaQmV4
	Jte0IOv3YSie7X0kr/SnU2tNMAahZUVGU0uMqOWotVKnXG9MEgqjzbCSoTVcwm9rWs82DR5E00O
	RX8OWn2ORuFsJlQh9+tKCDJY4Kdv/jfUvPThHrE7Ik3q33Mxqgq/m6RmBhRZF0yl45PS3cLD0vS
	llhtT8aOXWR12kigq07iNTuSGC7Y96rOU7OfH2RoOqyToOWAP2Mto2o71xZqZ9wpr47d9BOw1IJ
	xUx3y8vd0oYYeUs3p+UtS5teWfEG3Dppg6z8hgTtb2IAlIHIXzjwVcNbABGEVfUEQo/X4o3rXhl
	EeAImKqEeyXuV77boflmB+5gnHreDsSiXVzkN6ue1rugm
X-Received: by 2002:a05:690e:4807:b0:671:4f24:2126 with SMTP id
 956f58d0204a3-6717fdb0489mr1682517d50.59.1789936002636; Sun, 20 Sep 2026
 13:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-23-af4cf4767707@gmail.com> <20260916162814.434551F000FF@smtp.kernel.org>
In-Reply-To: <20260916162814.434551F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Sun, 20 Sep 2026 14:26:16 -0600
X-Gm-Features: AcwNN1V9f_cj4KFvVBI7cRGxNTARDn_RhISbjMBAMFhOdAADIUHjfDsp-6ULVao
Message-ID: <CAJfuBxwqBqTWavDX2t1dNx7BkpwrRj67WGcRp4P9ktXig6t3SQ@mail.gmail.com>
Subject: Re: [PATCH v10 23/38] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:28=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] dyndbg: init_bits relies on _DPRINTK_FLAGS_DEFAULT evaluated in =
wrong translation unit
> - [Medium] dyndbg: TOCTOU race in ddebug_sync_classbits() causes out-of-s=
ync debug state
> --
>
> commit 3b29729057e8a4b4e0401fd7f3a74205f701c129
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
>
> This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-serv=
er
> model using DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE.
> At module load time, it resolves reference records and automatically appl=
ies
> the initial bitmap to the module.
>
> Cc: linux-doc@vger.kernel.org
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 03dc35af4faa1..566c3860d7bfb 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > +static void ddebug_sync_classbits(const struct kernel_param *kp, const=
 char *modname)
> > +{
> > +     const struct ddebug_class_param *dcp =3D kp->arg;
> > +     u32 val, new_bits, init_bits;
> > +
> > +     if (!dcp || !dcp->map)
> > +             return;
> > +
> > +     init_bits =3D (_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAGS_PRINT) ?
> > +             CLASSMAP_BITMASK(dcp->map->length) : 0;
>
> [Severity: High]
> Does this evaluate _DPRINTK_FLAGS_DEFAULT in the context of the dynamic
> debug library rather than the target module's translation unit? Since
> dynamic_debug.c is not compiled with -DDEBUG, init_bits will always be
> evaluated as 0 here. Could this prevent the system from properly disablin=
g
> callsites for modules that are loaded and compiled with -DDEBUG?
>

yes. this code is misleading and has been removed.

what needs to be said ( Im looking for the place to say it once) is:

DEBUG is a local override  (1 file, or even 1 func,line )
to a param, which cannot possibly express its full range of behaviors

when DEBUG is used, it is honored.
In this case, to truly turn off the enabled sites, toggle them on,
then off again.

something like that..


> > +
> > +     switch (dcp->map->map_type) {
> > +     case DD_CLASS_TYPE_DISJOINT_BITS:
> > +             val =3D READ_ONCE(*dcp->bits);
> > +             new_bits =3D val;
> > +             v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
> > +             ddebug_apply_class_bitmap(dcp, &new_bits, init_bits, modn=
ame);
> > +             break;
> [ ... ]
> > @@ -1238,12 +1410,17 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> [ ... ]
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> >       mutex_unlock(&ddebug_lock);
> >
> > -     vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mo=
d_name);
> > +     if (dt->info.users.len)
> > +             ddebug_apply_class_users(&dt->info);
>
> [Severity: Medium]
> Could this introduce a time-of-check to time-of-use (TOCTOU) race conditi=
on
> between module loading and concurrent sysfs updates?
>
> Once ddebug_add_module() adds the module to ddebug_tables and drops the
> ddebug_lock, it proceeds to call ddebug_apply_class_users() (which then
> calls ddebug_sync_classbits()).
>

 In ddebug_add_module(), linking dt to the global ddebug_tables list
  and releasing ddebug_lock before calling ddebug_apply_class_maps() and
  ddebug_apply_class_users() is structurally required.

any changes to be made by apply-class-* only work cuz the module is on
the list scanned by ddebug-change() - which takes the lock, so we cannot.


Publishing dt on ddebug_tables is sufficient for both definers (maps)
  and users (users). The kernel module loader guarantees that definers
  load before users via ELF symbol dependencies on the exported classmap
  struct. Once linked, ddebug_find_valid_class() symmetrically resolves
  class_ids across di->maps and di->users, ddebug_apply_params()
  binds controlling_param and synchronizes initial bits, and the module
  is automatically included in all subsequent runtime sysfs writes and
  ">control" queries without requiring secondary registration.


> In ddebug_sync_classbits(), the parameter value is read via
> READ_ONCE(*dcp->bits) without holding the lock. If a concurrent sysfs wri=
te
> updates the parameter and applies it to all modules in ddebug_tables
> (including this newly added one), could the module load thread subsequent=
ly
> resume and apply the stale value it just read, leaving this module's debu=
g
> state out-of-sync with the global parameter?
>

since the effect of a param change is to call ddebug_change() which
takes the lock.
taking it around the param ingestion also sounds like a bad idea.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D23
