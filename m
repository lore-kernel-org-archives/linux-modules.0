Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BEEAE7
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767067144; cv=none; b=omZrdv5GJ/oGL7vf+bvXtBV1g7Q3AY3RGnVnESx9/48LpZKsLJVmQIlmnhz4h6EiqkC+kG2RB9anFtCK18PEjOWNfoDCPL3ASHKfxnNnixSzWjOJuv5wDOEHu5y+4lSO3dyqCRN+ypTFAdPxl8zn/OYdXnR9PrhIS8hmC5rMM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767067144; c=relaxed/simple;
	bh=bq+2qCBMb2Z72OGQhs+uhjtnqiFaiE88D1y5qNLHgeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uusAvqiNkHVTfDYkczMZFnSoPlQ9jbdp52atuN3rW9rtklqzXMFOsl7dJnsHFLui02mzMRMDS0tWavGpE1rwhkihET9pWSLbDdx6q0B/dBZHptCwQSB4aNCudzLZupl7aaIq9ueLPcqPUT3048U+bTFdTaT6k5zQzMS6vQIokTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqKoE3h5; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqKoE3h5"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6446704997cso7617505d50.2
        for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 19:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767067142; x=1767671942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z99KzVZpYkb3gtL8s7fwwktj39Jl+wZicuneMq7Dpj0=;
        b=UqKoE3h5ZuXv/qvdUdVs2OgcGHwP9UOdyoljU+ZLFgkD6l8kyKFOm1rKqAGhpwb0ez
         7KS4GW0313I+jyqC+JT4C9AFtEHyrSqaAcynPURjOKIyclOkqyXKCjzkkeSBDeQtTPNn
         zv9+F/j+U0cKPHxFndMccR7s6NlSitcyVJs82BO8sB/Lb/GNfdxrJm50csyhQACgoujA
         PqyXYfGPDck79Gvb72ekwm1vML1lzw+g8fF9WDFW2sMO7ZvObbBPB3wwfM3vmP0z0h2y
         ZzFiV1BwdMiGhdqr5zGdZkfQ5GRPCDZ96gPbs+THBBCGhPu73PgzzbOheeGOQZRaOurj
         hZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767067142; x=1767671942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z99KzVZpYkb3gtL8s7fwwktj39Jl+wZicuneMq7Dpj0=;
        b=WWbwzYqrQvllpZRDMtx8QgWgw4rAKp4CX4vPmWIxtgO3NjB7qKCnyLNf/b6AhYKGCu
         SUHQIaeydOzY/8rttS6fOJBMCcttx35Boq//+zHGsy0uGqiilffbZp2los9y0+DBlQX/
         cPkMEn3JZOK50hk1los7+Os3gsHl2ds2xDCZI233jgwB+pEvu82lrNgY5wiwxi5/5RRK
         p/K043Ohxb43El/butmuYyrJ+lT3hEmwy1lC+HAmvaViohDgcARPeye1E5z+Q72AfWKQ
         Y4qaSDeliaa1ZWaR4OHuN9lkOmWhob//RmXsTa6pYJ7GWJYQeDMh0ktF1jwYkW+xt7Rl
         n3xw==
X-Forwarded-Encrypted: i=1; AJvYcCX0WDnnT0ylsFOEZsPv1qyLYjPCDKxntTo/eBZlb4FfGkKvs0Kq1ETBSY7mdX7rJ6v0IMyAfpM5RWJ8Z+gC@vger.kernel.org
X-Gm-Message-State: AOJu0YziLeXFdxMq9yimK1oCTucOEQJ0VKRC+0JM01nvDdAnC5KrQiBN
	uC2inNjtLseut6TDIEAwE9emOzQyet6k2IW+YlQlyYsV5LGMYCHDoyy51KPXB5waVSr0Sygokoa
	v8ypR0eNdLTEWXxTCFe3DSsYjapLVHlA=
X-Gm-Gg: AY/fxX4wSPJpIlOe1DtZMCFFj8ygqPLOelKRCbKNTDyOsaFdxIN9DetcgTFavBQ0OTL
	GWolPzxydUzI2KA8J4nuLBfNFioQcD+pxnhoZLphtDB3DHJGIyMGMPns7HeHx6fQOyjG5rSuIk5
	326NsleN1hn2G7WIVS/XxmrxU7l+S2ZBJMoO/GP0mFfNKJDeGbkziFAPW9qW8YUlaPf6y5kkKTV
	fJyvj9NJ5rvvu02ShZk+9qur867OzEifW2E7pWzrmcaIBMs+y+tbMg9D3q20Hd+5Um4Qkh7
X-Google-Smtp-Source: AGHT+IHQIEx5N7DcJatWm3gOVIeC3KVHNmgmZBDt5tcU3I+HBX/0CwTgBrkwlOhbX5VJVqrZQXoeq0yFdhwXlbf2Djc=
X-Received: by 2002:a05:690e:11c2:b0:63f:7de1:7acf with SMTP id
 956f58d0204a3-6466a845eaamr27326779d50.22.1767067141713; Mon, 29 Dec 2025
 19:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229024556.25946-1-laoar.shao@gmail.com> <bdp2iitkjdmhl4ycfiu6d4sri3mmsqn2dd26p67heilu33bosv@zmkzcnyayqbt>
In-Reply-To: <bdp2iitkjdmhl4ycfiu6d4sri3mmsqn2dd26p67heilu33bosv@zmkzcnyayqbt>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 Dec 2025 11:58:25 +0800
X-Gm-Features: AQt7F2qf1W_WzHI3OI1pXm3VpGDzk33x1GbzQEA4i2TbiWZL3t3C-f4yOzxV2nk
Message-ID: <CALOAHbBLzBfirN38dokUQc6gxypx7nkwMWXLK05PGPdovVv3gQ@mail.gmail.com>
Subject: Re: [PATCH] module: show module version directly in print_modules()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:11=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
>
> On Mon, Dec 29, 2025 at 10:45:56AM +0800, Yafang Shao wrote:
> > We maintain a vmcore analysis script on each server that automatically
> > parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This hel=
ps
> > us save considerable effort by avoiding analysis of known bugs.
> >
> > For vmcores triggered by a driver bug, the system calls print_modules()=
 to
> > list the loaded modules. However, print_modules() does not output modul=
e
> > version information. Across a large fleet of servers, there are often m=
any
> > different module versions running simultaneously, and we need to know w=
hich
> > driver version caused a given vmcore.
> >
> > Currently, the only reliable way to obtain the module version associate=
d
> > with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself=E2=
=80=94an
> > operation that is resource-intensive. Therefore, we propose printing th=
e
> > driver version directly in the log, which is far more efficient.
> >
> > - Before this patch
> >
> >   Modules linked in: xfs nvidia-535.274.02(PO) nvme_core-1.0 mlx_compat=
(O)
> >   Unloaded tainted modules: nvidia_peermem(PO):1
> >
> > - After this patch
> >
> >   Modules linked in: xfs nvidia(PO) nvme_core mlx_compat(O)
> >   Unloaded tainted modules: nvidia_peermem(PO):1
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/module/main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 710ee30b3bea..1ad9afec8730 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3901,7 +3901,10 @@ void print_modules(void)
> >       list_for_each_entry_rcu(mod, &modules, list) {
> >               if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >                       continue;
> > -             pr_cont(" %s%s", mod->name, module_flags(mod, buf, true))=
;
> > +             pr_cont(" %s", mod->name);
> > +             if (mod->version)
> > +                     pr_cont("-%s", mod->version);
> > +             pr_cont("%s", module_flags(mod, buf, true));
> >       }
> >
> >       print_unloaded_tainted_modules();
> > --
> > 2.43.5
> >
>
> Hi Yafang,
>
> While I certainly appreciate the operational burden of managing a
> large-scale fleet and the desire to automate crash triage, I am somewhat
> hesitant to support this change in its current form.
>
> Perhaps the more appropriate approach would be to extend the existing
> module information infrastructure to include the version only when it is
> explicitly requested: introduce print_module_versions().

Isn't that redundant since print_modules() already outputs module names?

>
> In my view, while the requirement for better version visibility is valid,
> we must ensure that the change does not compromise the readability of the
> crash report for the rest of the community.

I understand your concern, but could you elaborate on the potential
troubles? The extraction is straightforward with simple text
processing.

$  cat vmcore-dmesg.txt | awk -F': ' '/Modules linked
in:/{gsub(/\([^)]*\)/, "", $2); n=3Dsplit($2,a," "); for(i=3D1;i<=3Dn;i++)
if(a[i]!=3D"") print a[i]}'

Besides, kernel logs aren't an ABI=E2=80=94developers are expected to adapt=
 to
upstream changes. Otherwise, the kernel itself would become
unmaintainable.


>
> Nacked-by: Aaron Tomlin <atomlin@atomlin.com>


--=20
Regards
Yafang
