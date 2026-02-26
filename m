Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53696374733
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072373; cv=pass; b=NSC1J5TWdUtu6nlKlgA7RM5lATor6IXQ9nvTPJ5u5zgtXx3GGFrs7n7yyDSDvdHKn2N27oNowiXBYqOQfuGBzHmYPbkpRm9iiDYDDKvj8wHS6/WKYzF2lIB6LjFav/x+vvssu+J9EXN3/nnFKkhO33y/hVi3nGsbQNSrbWig5CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072373; c=relaxed/simple;
	bh=cLzlljzK9C4sAI2eoDoXahDWNnpEZfyXpBbhwKLwyMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGJ8jTgZ+GkLffWkYpbSkHWBBxe+AQRdUbm6Q4mfA+W7nC3byoNhA8d6GfcV0ZJJObNKxNsMrFVWY5YI8uu6bjhmpUmCJM270Q8q/n13ndngeKOZo2Bpf6ztOc+x6YFrvtq/m5Lh0jxM1aKZ5VAYIF14DGrakF2UkyV7yuvgM2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQoCVkuk; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQoCVkuk"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79863ab8478so3213107b3.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Feb 2026 18:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772072371; cv=none;
        d=google.com; s=arc-20240605;
        b=f2hFB9LEcBRiKGUfryx3ffG/pBCR6H3eot+PL3VW1REw7SMZaPWzfcHeegcGCmtkEx
         nUxNPAIpGtyvSURWSQdFEVp/XP+WhDbYRhao+HF7/MZeV/8TREIiG0qogns0E31F0vp6
         7rC1k0yPc6xS2a/fuA0txTe03MbYbOOkOFtKkookSMyYDuTui9sa/NzkiCOQ2v/3h2ly
         ikkTTFXcufPvysYxaYLeH+ZZaM0xiLG/cqBqm4116xTG/s5/ie+Nkm2qH3YS39wDqVCs
         dWTzBWK7YXO6DeGVAMtOIAhnvtQkjoessgIIRiMQfxsQjBpdsbtkmVAbr8n0/P6zjrWU
         EgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqhHQA+pQ+p8DHC8y7YMlY+2BCSnJTgBmJxNuF6a+pU=;
        fh=sFWtu6c+50c5t94aLQkKx4o5OgrkUN9VJPgruKYhNoM=;
        b=lXLAnuYRYtMS1Kznvq+JMPfCxeNAbEXS1bt6LeCZUDybEBkjot6OT+Dip2WmPxwUV6
         OVGbWpjq3NaLR4iQoSHFwtv57HSRd7NHsLEozLrgalvgpfaQoKjgyLquc/1iRfQjLSV2
         pX6iKoVfqyIaRzC/R6Lv77rh/kGszoL1EI5qCZHIwchEDHn03JyyiVFxg8C7ntj2BJjN
         jhKrI0WVXJcpqYfMEJJvCd7XHiMLsYuUGm662RvA0TNtDS3BtoOACwGQRpVL4kFq48uj
         SwyKSmy1oCKLFKGihCFeOliNpHSaartL5dYVRc1pFBJSUlK5gG6G97cmuEOMDh982Q/5
         gy3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772072371; x=1772677171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqhHQA+pQ+p8DHC8y7YMlY+2BCSnJTgBmJxNuF6a+pU=;
        b=EQoCVkukmKdWCnVX1sykR0SvRH5zTy8WNONGKoWGrDQ7EM1dy68xVb6AFS3Oy40U4O
         ZnSXp9ZOlc6bozZyU/NpJVdjvIEJ4LjDhv9PrXJixWdUgDZpDfHCItcghJA+1PighNQh
         vL8CFKmHba5fzxMhK2B8SCZtkGkQhZamcYLjXTgaRyYy4YHF+r5TO1ssspeaLhXhmlN7
         TlOjX2QMwDj6tFW0JoclnV3xvrXZmm6XXMADjdzqK46UiQmjQlnyy+cqWT6lE585o1lL
         pxcHfRZ8OqsKvsPS5qT4QvzUcABifR62HP3igmFMmMFN/1dmgu3NxIKDGwjsqTF0GCm2
         Sq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772072371; x=1772677171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqhHQA+pQ+p8DHC8y7YMlY+2BCSnJTgBmJxNuF6a+pU=;
        b=SF+6OYaoaTx19dMHRAuistaBudj957oVygOMaP1BR+FOEVn6Ux/9aDVMJbad8xW+/v
         DWvNA/hzi2nGTOl8+/zx/4zBMfTVZwUDg7NDJsXJmZGTSY+3YtY8+Q43EBui19qwVY4Y
         U5Yw5M2ezQ95U64S3Agrke29t6y8TTrQPu/w9cHFZF9j5RZVdl/zc0ZMck/883HG7ZvC
         80Ssxw4F1NeAy+jFXkYAoKPNrUi5bu/gvJrI/+AmiIub94wnifsyyJ3grknsg3LfSprj
         RkLrHS3uXG6696eE5Z3u5vpT63qMco/BVTKColrLTiJYchMrpn46wEuzg/K6xHA/78J/
         vOYw==
X-Gm-Message-State: AOJu0Yz8O4jPwjMGEKnjjrNSBa9ox45LM7xboIC01l5YF41HeLxTaEql
	CiBAvopSHyhW3yZZfrzRaK0dVjoNJc24PxW7EQaQWYBbnvnfC08kLSfb4sQ0fTnJB7mBXwa/3QO
	d0FNHX9I1bPl3gH7VFrSvJDTneWesAqY=
X-Gm-Gg: ATEYQzxUFcIIiaZH+QOdduxXBGSq6mzt+Bl7npMNkez/BfyuYWen/uwSZyIU86PlWH3
	5cpz2Mxd2C6yopRW2G+u3eVZs6ok6rEUnFPt4evx27LZfu373aHSHCT1gJV+RJfB3cLlad4S3OT
	d5HFMFoAWxc76yg1H14B57Nc4Gim9uhSFB6BX1reG78LrOHlh3uEiqOsCZ58gE6Oybsgv2KMQQg
	RDop0eDIlwU5DOAY6Dxy44CxsvZceqJuJQxPfVEed+mijhWerKVEmzQqpUosa7m5vxz4/I+kawM
	+Pyn4e6x
X-Received: by 2002:a05:690c:dd5:b0:798:77ee:cc2c with SMTP id
 00721157ae682-79877eed54fmr3824107b3.62.1772072371270; Wed, 25 Feb 2026
 18:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231094004.37851-1-laoar.shao@gmail.com>
In-Reply-To: <20251231094004.37851-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Feb 2026 10:18:55 +0800
X-Gm-Features: AaiRm51ugG1-_872846VhxRvBbcSsVplqxg_NI9kHq42XNDMKLKZb12gYlWiCnQ
Message-ID: <CALOAHbA5fkK8XSqo62=k1hVX+krx58eUWMLNwMdwncAp+Xn4=w@mail.gmail.com>
Subject: Re: [PATCH v2] module: print version for external modules in print_modules()
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 5:40=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We maintain a vmcore analysis script on each server that automatically
> parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
> us save considerable effort by avoiding analysis of known bugs.
>
> For vmcores triggered by a driver bug, the system calls print_modules() t=
o
> list the loaded modules. However, print_modules() does not output module
> version information. Across a large fleet of servers, there are often man=
y
> different module versions running simultaneously, and we need to know whi=
ch
> driver version caused a given vmcore.
>
> Currently, the only reliable way to obtain the module version associated
> with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself=E2=80=
=94an
> operation that is resource-intensive. Therefore, we propose printing the
> driver version directly in the log, which is far more efficient.
>
> The motivation behind this change is that the external NVIDIA driver
> [0] frequently causes kernel panics across our server fleet.
> While we continuously upgrade to newer NVIDIA driver versions,
> upgrading the entire fleet is time-consuming. Therefore, we need to
> identify which driver version is responsible for each panic.
>
> In-tree modules are tied to the specific kernel version already, so
> printing their versions is redundant. However, for external drivers (like
> proprietary networking or GPU stacks), the version is the single most
> critical piece of metadata for triage. Therefore, to avoid bloating the
> information about loaded modules, we only print the version for external
> modules.
>
> - Before this patch
>
>   Modules linked in: mlx5_core(O) nvidia(PO) nvme_core
>
> - After this patch
>
>   Modules linked in: mlx5_core-5.8-2.0.3(O) nvidia-535.274.02(PO) nvme_co=
re
>                               ^^^^^^^^^^          ^^^^^^^^^^^
>
>   Note: nvme_core is a in-tree module[1], so its version isn't printed.
>
> Link: https://github.com/NVIDIA/open-gpu-kernel-modules/tags [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/nvme/host/core.c?h=3Dv6.19-rc3#n5448 [1]
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/module/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> ---
> v1->v2:
> - print it for external module only (Petr, Aaron)
> - add comment for it (Aaron)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..16263ce23e92 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3901,7 +3901,11 @@ void print_modules(void)
>         list_for_each_entry_rcu(mod, &modules, list) {
>                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>                         continue;
> -               pr_cont(" %s%s", mod->name, module_flags(mod, buf, true))=
;
> +               pr_cont(" %s", mod->name);
> +               /* Only append version for out-of-tree modules */
> +               if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->tain=
ts))
> +                       pr_cont("-%s", mod->version);
> +               pr_cont("%s", module_flags(mod, buf, true));
>         }
>
>         print_unloaded_tainted_modules();
> --
> 2.43.5
>

Just checking in on this patch. It looks like it hasn't been merged
yet. Is it good to go, or does it need something else?

--=20
Regards
Yafang
