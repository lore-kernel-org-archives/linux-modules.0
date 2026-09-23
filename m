Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E182F3C18
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131586; cv=pass; b=AqV8mHl7FzlH2eg1vFcvLsMH2X/9+5/9G9qQWKsm8Hcin8G8u5Aim+wil4mbq87fU0oGu0oA+pk0CPz0y0T1cyAc4vBmIotw5t2w0+gx/kVJfyhqfWLsyx9vueORh8dRKWpn3fvASD0GbkySPIw8SQxKhjga19pXvOf4p1Iwx44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131586; c=relaxed/simple;
	bh=kmwED0F7EVhtTZgnbPWq4Ccrr/KizV9OlK48mu3PyOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKnSqZI1O8trn9wJIwa5anuQY9A6/79HEr0pFQm5MUWut1sL8qaHlPpecptytc8hSMRhTaUuvjetQTPbuzWek1psgz1tZD1Aam60V2sst8P6qHBnA3GzDbqtQmO8v8xvlw8HWv8jEQgm4HvgjzabsRIe2krWX4PTUbQqZsFr9Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhsD4ax6; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhsD4ax6"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-532e9ad9a1eso74751cf.0
        for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 19:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790131579; cv=none;
        d=google.com; s=arc-20260327;
        b=P7qPfj6BB68Cocfe+yoXdBbaYBViJ1y8qlxTWdG2Ro4S9K2HHn6cIaFRq+b62L1OBW
         1P1pFwggBBkmVUIfXM2rAQX0TDH9LcoWpwx4e4B+DhpZOh4NCBrs73ob+silqRk9sstb
         psxh8GlIL9tyglKEqXo9ZNokvqHQ2QptUXhZrT40ItfQ3UaE0XkITU3F+2+FsYLiu5Oj
         bagQgQ9sEY7G1stu9FnLWNtwyXzmlWiiWMTIJ34oUeqWLxHbrh07rf7d9fbZMShuA/I+
         JL80oRBQGZ2eTgu6TFSXe9KKAHg3EzCrhV2WzujJF0gzSLqTP57v16cyntE+ChLR0ms0
         m/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        fh=OoKMwjg5e/ZMMON0FA7qbuu/yfXeIKCuDWEjIRmfr4M=;
        b=Zk5Ywrxjq8irfTP4wowLUm4Udwa7MBaFNZEwg5TEIZPXCr9Ok+gpvSi+4jnwBMjXb1
         UyZTQw2qhTXqWjJbnVQ+OBfoj4JSABXqlAqvR97pHAn7aupNLvjrqbKJyG/pIu7UzNut
         cNvZg+WiFlSl+TqrjXOQPfmePnqSNAlzRTgP8lNE74nodidN2sIh4axkh8OFNAfilM0e
         Y6G93mwzXMQIaJ8+GFKkrkVua2qoYgpI3xJubSTGPCFgw2h9AHwnPWk8tYjH3rp/zzwA
         /XdCDDIf5riaAcVpsytXH2UmQPbcDY2IL8D3HPLx/3dS0sQvNZNN+n3qrwUTYB8cRNPi
         p/Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790131579; x=1790736379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        b=FhsD4ax6CjKafXoJ1RrdhIPO2TAZB3nglt7RVhl+qW3d/8W1b9DWNxaiJwMYsaIrfL
         7vU+CAFu8owbdivVei+xLd4UynDY2wJJgz4+DC1Ggnbzdy4wwi++X3HCiayBbiNSDMda
         EJ0J74sDMHIBeNs3NeBt0L7iO/zT2dbhLJz05syk42oyUbMgXYq4u/8JoveEow2tM/o0
         0etVB4UZrMnOqaKCphClQ1TXrcvLBImFcGtbWh3MSDbf5EZmrWA8rIOQ6hu6xvDr37Qa
         dPlETHFMgHbPamNNlL4MBMeLGreMbIR86ghVb7mGQ+TEOrmTTBE+PYsMbWAhcRXSD391
         1FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790131579; x=1790736379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8uOFzpnkzf/kQZI5AxzptgiLFgV6BJGWg7vBofd0M4=;
        b=p2crq5gy7Dcrn5ug+jV4N1+Bni5nQb++ywmfdR649w+tadAECWA8YCnWsEVVs4BrS2
         WdJiU0+gKSCqAupBFKPzvKImmxtw5XLB1P3yCJGw9Zy3zqpvmtThiMKbdi4le46u3rJZ
         eGScl+9/MuU54y7T12Do8UeK3TC6QJuLekPrs9lKxJcbmaBNtLZFC3bOs2RlQefwYwb0
         gIl94c31aP5BmPDkD0kg5vbvAHcUL/hWLTuIEWrs6JAwlD9gQh/dJenBDOpEzuvWKqUg
         Qh4A2Feo1CZ3TXLShE72I100dghDg3vIfEwvyCLg4NEq1j5s2EMqik0V4UXkMpsUJRyc
         0wYg==
X-Forwarded-Encrypted: i=1; AKwUvBxIBkiIZ2TbVHnKk8AmIC3ytv9IKIk6p72SG5+q51uy0rppoBUBiwrtPvMkZh/chrFXSoBQjAyqsFP+qkx7@vger.kernel.org
X-Gm-Message-State: AFuF++mNDOtKFJQsKkAYDHGed+4EtEyBiabiZmN7wFqxrF6wlp/m4Fln
	T4WMkUPRqx1octtceNyONPyzIAUfw4DgmEWaRrT3Etn/bW9Wv0wD4G7sNu/TItm9SJ2Z+XST+zb
	z/GVwgZ7orRDsO1QmLL2K3ohAEUW8i9cWWmewkDGm
X-Gm-Gg: AYBFou3Z4NpQxeJ2kUGPhJoYOqD8xU+KUZyA6kAc5o7yq4DC0Q3h4O+bPJzEhIgINfG
	9roaXLOigPz4j1kTgHYkQJmR2o8XkFHLarW2uSpRYnjyqy6Q0VTWht0OTwdDGv3kC49AVgEQ0vA
	W5zevb+uDYBtjzMWtk9vOi0jaIjneFBKeqycbeYQICVpqZQcOOiJotwTmjKcdT3OgxEgBnOvkqI
	zXbd0Me3yFjcgEA+qqg/J+T10SrnF1+3p51kn3I7FDBRYeU9GESUZsS0ho/WfCdxmTtJRI/FKy/
	RayGBo0tbSpo7d3Rl0K4TFNjuY8LcPqFib+glnaSL8bNQtb0YVzDYxA=
X-Received: by 2002:a05:622a:11ca:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-532eb7fee7dmr8415971cf.0.1790131577959; Tue, 22 Sep 2026
 19:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-6-hao.ge@linux.dev>
 <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com> <f16c55ba-3403-4721-9ff1-061d73e17fa5@linux.dev>
In-Reply-To: <f16c55ba-3403-4721-9ff1-061d73e17fa5@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Sep 2026 19:46:05 -0700
X-Gm-Features: AclHuK-77SC-AzzB_PEzWsM6m_1tPyT3YYUd84GMA5eJaxU9zbpMbRcwXBAS0q0
Message-ID: <CAJuCfpFT-DVa3W6_tNAxoSPjw5bu=eadYsCmhFX2=twQLTNcvg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:36=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> On 2026/9/18 08:53, Suren Baghdasaryan wrote:
> > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> After shutdown_mem_profiling() clears mem_profiling_support,
> >> needs_section_mem() returns false, so later modules have their codetag
> >> section placed as regular data and never enter the alloc_tag maple tre=
e.
> >> codetag_load_module() still called load_module(), which allocated a pe=
rcpu
> >> counter for every tag; release_module_tags() could not find these modu=
les
> >> on unload, so the counters leaked.
> >>
> >> Return -EOPNOTSUPP from load_module() when profiling is off:
> >> codetag_module_init() drops the module's cmod, no counters are allocat=
ed
> >> and the module loads without its tags. codetag_unload_module() now alw=
ays
> >> calls free_section_mem(), since a module whose module_load() returned
> >> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
> >>
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compr=
ession")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> >> Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Yeah, I guess I didn't think about alternatives...
> >
> > When mem_profiling_support=3Dfalse, why can't load_module() skip
> > allocating percpu counters, zero out the whole area between start_tag
> > and stop_tag and return 0 as success (mem_profiling_support is not
> > enabled, so we acted accordingly)?
> > Module will be added into maple tree and later codetag_unload_module()
> > will find the module, call release_module_tags() (which is a NOOP
> > because tag->counter=3D=3DNULL) and finally call free_section_mem(). Th=
is
> > seems more natural than special-casing with EOPNOTSUPP. WDYT?
> >
>
> I see, but the module would then sit in the idr with NULL-counter
> tags that become visible to readers which today never expect that state.
>
> alloc_tag_top_users calls codetag_next_ct() to find the next codetag
> and alloc_tag_read() would do per_cpu_ptr(NULL) for each cpu - plain
> pointer arithmetic onto a wild address, an oops straight out of the
> OOM report.
>
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/alloc_tag.c#L503
>
> So if the codetag section within this codetag_type ends up meaningless,
> is there a reason we still return success? We will still maintain cttype-=
>count
> and allocate a slot for this module inside mod_idr.
>
> I'd rather keep the -EOPNOTSUPP version (your original suggestion),
> also because the comments in load_module() and codetag_module_init()
> already document this scenario.
>
> WDYT?

Ok, fair enough. I think your current fix is the simplest way to
resolve this issue, so let's keep it simple.

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks
> Best Regards
> Hao
>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  lib/codetag.c  | 10 ++++++++--
> >>  mm/alloc_tag.c |  4 ++++
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/codetag.c b/lib/codetag.c
> >> index a9cda4c962a3..a0b600720afc 100644
> >> --- a/lib/codetag.c
> >> +++ b/lib/codetag.c
> >> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type=
 *cttype, struct module *mod)
> >>
> >>         if (err < 0) {
> >>                 kfree(cmod);
> >> -               return err;
> >> +               /* -EOPNOTSUPP means we can load the module without it=
s tag. */
> >> +               if (err !=3D -EOPNOTSUPP)
> >> +                       return err;
> >>         }
> >>
> >>         return 0;
> >> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
> >>                         ++cttype->content_id;
> >>                 }
> >>                 up_write(&cttype->mod_lock);
> >> -               if (found && cttype->desc.free_section_mem)
> >> +               /*
> >> +                * A module whose module_load() returned -EOPNOTSUPP i=
s not
> >> +                * in the idr but may still hold reserved section memo=
ry.
> >> +                */
> >> +               if (cttype->desc.free_section_mem)
> >>                         cttype->desc.free_section_mem(mod, true);
> >>         }
> >>         mutex_unlock(&codetag_lock);
> >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >> index 5836803898ad..1ca0409b492b 100644
> >> --- a/mm/alloc_tag.c
> >> +++ b/mm/alloc_tag.c
> >> @@ -988,6 +988,10 @@ static int load_module(struct module *mod, struct=
 codetag *start, struct codetag
> >>         struct alloc_tag *stop_tag;
> >>         struct alloc_tag *tag;
> >>
> >> +       /* Profiling disabled: load the module without its tags. */
> >> +       if (!mem_profiling_support)
> >> +               return -EOPNOTSUPP;
> >> +
> >>         /* percpu counters for core allocations are already statically=
 allocated */
> >>         if (!mod)
> >>                 return 0;
> >> --
> >> 2.25.1
> >>
