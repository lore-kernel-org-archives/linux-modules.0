Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601235C1AD
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891331; cv=pass; b=TPNquQimEEj89g8krejk5VS+h3DlJRcuMawpUVNGjHodxkqBm9PYhN2VHN4HooXFuWQ9CZfqFF43N48aKRQxMsrF26RWMhlU9CAdslaqEOVEcq31xelwIFRGePq0mq2OwNkybzzaMqZPC/Xe0TXX/QPjdl8uPemw9k0vCra1EJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891331; c=relaxed/simple;
	bh=k6v4N3fQcBAwgPIa+eEVArEBhH9E4XZ3TbkGxaeXGuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ei9U/4q+2ZBnnmG5pPBa9/JptL9BFKg+oqImPxOS8EJ6L3HoJI89b/89ydUvwJuAfeN4veEZ2+n3M3bFeCP2Dk9PFR6i2iH4ndVyECLad1xi5lVtr8iNLNvbChoc3+vpUDNvFN2EwPVstFed7cPsI/5eQPbLPNyu8HxuWWzjoM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YknUU0ad; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YknUU0ad"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso7220344d50.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 14:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891328; cv=none;
        d=google.com; s=arc-20260327;
        b=VLQ3ypMJIyeQ/MFCGByY1zBtC1RidEMqaH+bUkk8R14X+82qcMeqEPoiYWE9vZanTW
         AvWAD+nQtjOvsgYuKzscMplVplo0jgiZdweBwH1tWM4889o2Z1aDz4bqK2YCcVMRpfbo
         qaDf4k1R6ViFkUoTjSexhgmJgVC7WipEtH//mHeE19prK42SN7Mzc40IRyjkpAiMjZUu
         vp0gPSOf/nLx4S8xslhxU6Crla48HEHUSVAMt9QnvxtFkuW4OgGBZGwIJ3cZyYuSmRwb
         KUrVj68hambyScnuH5lqFGocK9pr/dsI8i6FvPv98MJR26Pl5viGqbOVB6PVFagUtFC7
         lJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
        fh=hDIeoOU21Fodj5QZYNrGswseFwzEiLHbCeTclE5IsRg=;
        b=gYrbW039jhceCyCqK1DzyWLkW1pyk8FfBP+UyxPr2DfJTLQWBFpCp0bQfjX1r++IIG
         r5wCCQYbQE0f72NH7NLB9J+tac7BmllGmA5Y3NuBbYlWvbw6h1By/zGTguSTLVB102pu
         NBV4jY1MQIyT9IdTsC3HXUOz3ynG+aLLoQ3+/WEYxPBrgtZamyDDkJjTmBs04X4q1Oau
         iN/j4wzMAeOs5QRD4vSBvmkglkRrdRiE/9lTlnoka51c7GCH6FDqvoRd+hrvnwE0AgKW
         nVSsh5uy65tTBAmPN2NyifoF5O6RtOUdhb5atZzqbLtAI3UIWKSyUPNNm04njuI0nOR/
         Rlfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790891328; x=1791496128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
        b=YknUU0advW6jHSGfyhye6OASkU/+ozkQRnSN7ZuoLrCDdOfH+lPjuj5ZAlaOAOscqH
         KQIaxJZJxGBBD8eVVBErn7IjSTYrNGwj5zEFC464r5kBgdDsIATUeTMxllfHqx8I+Nts
         by9XQmMSzHsmrT0m3vXDvSV84NHo8f9uNwDp/2JepNfGqVBYj3VvDxRR3joN/Aj7r3fB
         XLX53LVPIf4Zj0UpXwYpSmtuYD9lCsrxBzdoaxDWHTLT8ekG63InVEczXnVmjVheTpvi
         +TCP1A8+3H6CJ62vLnR+bvD3MYECQGXjrnnhhe6wXS4cJINMzrGyaLXSdFyncEM7NaME
         vucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790891328; x=1791496128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxEBbkBDr98zgUdqxxzSaXIdqAeCMXlZGMeNUHK5+N8=;
        b=w6VjrVgbstlErNkool9fZc2liOynaJV7eKxF0hkZSBief2FK5mhz4Ac9am78BIsRUP
         e7o8AwrOqs0NYgHXMTTiVbR+gK96CbfT4pdCevca0gAtSS1fQF7YGVoekn8bgH7LHevb
         4AcDXYxPHWhkXFWn7Qdo+MpFGQOslWTuB56V0RErDFme6uVEIoqQrDEgmUpEjb34u4if
         AfF2I/Q2V6ddGYaa82/sMJIze1IxfCXsM6V1JQYNKPScwdC0SBlL+qunlA586uYL2gc5
         ieHQPpzZlwfFnUQ13yTNYbHKuxglo9Bon4P7Ry4w3C0+s06/6msT020AieCoreHxItrY
         aFWA==
X-Forwarded-Encrypted: i=1; AKwUvByxMWZkke+vGbgKBF/2mzMKIE8sGbLXvFIjtS2wx2ffMxx+22nE4crFAPJyl/YrwIoMLW881SdoILh6es5u@vger.kernel.org
X-Gm-Message-State: AFq9FYKOUgF5hjdKUrFx7hypL/dYCgZ8y5Fi+eN/XJlbZPYMIB+gh9sk
	gSvIK0EbsGgNbrxwLGFjVq1zERNq2FsYha8OMW2qkxrBMRAXXd6v7To/y2y2sYFV39rSKL4oCYh
	PI4WUe+2wMYgSQdG9W+yG1S+jKbMmOKeWyg==
X-Gm-Gg: AYBFou0FRhARyDaE/y/qqYHpTaAw5mXP+53YArTfRRsQgMfT9pcymaMkwzFlGM0RjCy
	xLXj9QlO6HHn7KlpgIA/ITP69/2NP/iEuqmnz0ad/2JUzVzNT8Q6fzOUVhzp9mBjezeWMFAB0mz
	RgvEwyqdkAt4f21EknJc4q0W6bX30vmDqOCTC3aKGZfhsKHsqhT2JOVCxhy+xeJgZxwq1+coyI0
	5eX5GO52ArpxGjqCV1v+VdwNASp/DfjefKgBAjQ1BkVQp400GJHlQsqzoNCfYuRs1EUjWFMD23y
	pNYePZscFpXsXzDRybIjyznPhDsP3JyckqI2A16KSgmUjsNIjkbXL5coERNRI6y4XLCLJWj2j7d
	RP61pl4SCILqTtBgXiesdZRHf4aobrzMl8g==
X-Received: by 2002:a05:690e:168e:b0:673:1df3:86b2 with SMTP id
 956f58d0204a3-677ac0a5637mr405865d50.66.1790891328358; Thu, 01 Oct 2026
 14:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-32-9b6c217fdf2f@gmail.com> <20260923225318.68FA81F000FF@smtp.kernel.org>
In-Reply-To: <20260923225318.68FA81F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 15:48:21 -0600
X-Gm-Features: AclHuK89WETVF5kBKceq7LGgHNh99DFnvQVhaT61KjOm5bX44GqQ2b5VPPdB404
Message-ID: <CAJfuBxw6=rmCZ-YXyDjxUVZCKpXf+5oLUgGqDnmeXu=PfrLJ4Q@mail.gmail.com>
Subject: Re: [PATCH v11 32/38] dyndbg: resolve "protection" of class'd pr_debug
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: race during module load bypasses ABI protection perman=
ently
> --
>
> commit c8a052c030fff7b63aa2d9e4c2dc3aa455948704
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: resolve "protection" of class'd pr_debug
>
> This patch implements an ABI protection mechanism for dynamically debugge=
d
> classes by binding a controlling sysfs parameter to classmaps. If a modul=
e
> parameter is configured, it protects class'd callsites from being
> accidentally modified by un-classed wildcard queries.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 636a88994a774..d300d44c1a82e 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -252,7 +294,28 @@ static bool ddebug_match_desc(const struct ddebug_=
query *query,
> >           dp->lineno > query->last_lineno)
> >               return false;
> >
> > -     return true;
> > +     /*
> > +      * above are all satisfied, so we can make final decisions:
> > +      * 1- class FOO or implied class __DEFAULT__
> > +      * 2- site.is_classed or not
> > +      */
> > +     if (query->class_string) {
> > +             /* class FOO given, exact match required */
> > +             return (dp->class_id =3D=3D selected_class);
> > +     }
> > +     /* query class __DEFAULT__ by omission. */
> > +     if (dp->class_id =3D=3D _DPRINTK_CLASS_DFLT) {
> > +             /* un-classed site */
> > +             return true;
> > +     }
> > +     /* site is class'd */
> > +     site_map =3D ddebug_find_map_by_class_id(di, dp->class_id);
> > +     if (!site_map) {
> > +             WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP de=
finitions", dp->class_id, di->mod_name);
> > +             return false;
> > +     }
> > +     /* module(-param) decides protection */
> > +     return !ddebug_class_wants_protection(site_map);
> >  }
>
> [Severity: Medium]
> Does this code expose a race condition when a module is loading?
>
> Looking at ddebug_add_module(), the module is added to ddebug_tables and =
the
> ddebug_lock is dropped before map->controlling_param is initialized:
>
> lib/dynamic_debug.c:ddebug_add_module() {
>         ...
>         mutex_lock(&ddebug_lock);
>         list_add_tail(&dt->link, &ddebug_tables);
>         mutex_unlock(&ddebug_lock);
>
>         if (dt->info.maps.len)
>                 ddebug_apply_class_maps(&dt->info);
>         ...
> }
>
> If a concurrent wildcard query (like echo -p > /proc/dynamic_debug/contro=
l)
> is processed while the lock is dropped but before ddebug_apply_class_maps=
()
> finishes binding the parameter, site_map->controlling_param will be NULL.
>
> This causes ddebug_class_wants_protection() to return false, bypassing th=
e
> protection and erroneously enabling the callsites.
>

yes, theres a narrow window where a module w classd pr-debugs
is changeable with "+p" flags, before the controlling-param is set up.

Once the protection is in place, "-p" will not be able to undo the "+p".
Only toggling the param itself will undo those "+p"s

v12 addresses this by setting the controlling-param before the module
is added to the ddebug-tables list, and not in the class-map-attach




> [ ... ]
>
> > @@ -772,11 +833,14 @@ static int param_set_dyndbg_module_classes(const =
char *instr,
> >                                          const struct kernel_param *kp,
> >                                          const char *mod_name)
> >  {
> > -     const struct ddebug_class_param *dcp =3D kp->arg;
> > -     const struct ddebug_class_map *map =3D dcp->map;
> > +     struct ddebug_class_param *dcp =3D kp->arg;
> > +     struct ddebug_class_map *map =3D dcp->map;
> >       u32 inrep, new_bits, old_bits, old_val;
> >       int rc, totct =3D 0;
> >
> > +     if (map && !map->controlling_param)
> > +             map->controlling_param =3D dcp;
>
> [Severity: Medium]
> Is it safe to assign map->controlling_param here without holding
> ddebug_lock or using WRITE_ONCE()?
>
> Since this shared state is accessed by concurrent queries, could this
> cause a data race?
>
> [ ... ]
>
> > @@ -1332,25 +1395,40 @@ static void ddebug_sync_classbits(const struct =
kernel_param *kp, const char *mod
> >       }
> >  }
> >
> > -static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> > -                                   const struct ddebug_class_map *map,
> > -                                   const char *mod_name)
> > +static struct ddebug_class_param *
> > +ddebug_get_classmap_kparam(const struct kernel_param *kp,
> > +                        const struct ddebug_class_map *map)
> > +{
> > +     struct ddebug_class_param *dcp;
> > +
> > +     if (kp->ops !=3D &param_ops_dyndbg_classes)
> > +             return NULL;
> > +
> > +     dcp =3D (struct ddebug_class_param *)kp->arg;
> > +     return (map =3D=3D dcp->map)
> > +             ? dcp : (struct ddebug_class_param *)NULL;
> > +}
> > +
> > +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> > +                                   struct ddebug_class_map *map,
> > +                                   const char *mod_name)
> >  {
> > +     struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp,=
 map);
> >
> >       if (dcp && dcp->map =3D=3D map) {
> > +             /*
> > +              * Bind controlling_param to activate ABI protection in
> > +              * ddebug_match_desc(), shielding callsites from non-clas=
s
> > +              * wildcard (>control) queries.
> > +              */
> > +             map->controlling_param =3D dcp;
> >               v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->=
bits);
> >               vpr_cm_info(map, " %s maps ", mod_name);
> >               ddebug_sync_classbits(kp, mod_name);
> >       }
> >  }
>
> [Severity: Medium]
> Can the delayed assignment of map->controlling_param combined with
> ddebug_sync_classbits() result in permanent desynchronization?
>
> During the race window in ddebug_add_module() mentioned above, callsites
> can be erroneously enabled by a concurrent query. Once the module loading
> thread resumes, it binds map->controlling_param here and calls
> ddebug_sync_classbits().
>
> However, ddebug_sync_classbits() passes 0 for old_bits:
>
> lib/dynamic_debug.c:ddebug_sync_classbits() {
>         ...
>         case DD_CLASS_TYPE_DISJOINT_BITS:
>                 val =3D READ_ONCE(*dcp->bits);
>                 new_bits =3D val;
>                 v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bit=
s);
>                 ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
>         ...
> }
>
> Because old_bits is 0, the function skips resetting any class bits that a=
re
> supposed to be off (since it sees new_bits (0) =3D=3D old_bits (0)). Does=
n't this
> prevent the synchronizer from noticing and clearing the erroneously enabl=
ed
> callsites?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D32
