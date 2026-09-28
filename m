Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61D4915A9
	for <linux-modules@vger.kernel.org>; Mon, 28 Sep 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589237; cv=none; b=CEKsEo5jvZhBtB05HBKVLlqLOW6oQLZBrQeI2iVoNTmlk60QoGpD/2WAILPqSgiazJN//ImK3dO5toXBfaymhb4BmBjD67RC2Z5s7tcvtdfuwnbWKlE9UAe7/kimPP7iLI0v8Pssza3ssPPf8/+tMZLoXsu47Xub8kdWMWtUyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589237; c=relaxed/simple;
	bh=mXlMxmlL0FCNrGyBpcyx+dWJuiW6H8zzigvVTYrhlCM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/57n5+3f9ox02pGe5Y2cu90jPJDoRrWygFS4rvQEBUX6d0iCiMzjt19rATVjDB6QXWgSaOo+6Uf0jwolIeERvogOyg0qO17z9w/SEjNAepFe6wKpGS6/Y1F/V+sg4OVKmnQNJ7kCs9sm+tVauiu9N+8CUjp2/DUO5618eE8eGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io3Jzd7m; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io3Jzd7m"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af3a4f193so284446766b.3
        for <linux-modules@vger.kernel.org>; Mon, 28 Sep 2026 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790589233; x=1791194033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJTLKL9T8vepgzmrMMl9hUBXjorXrkUQap53+72PCy8=;
        b=Io3Jzd7mvaFarYjW7U9ipoUHvYm1LRy/ccwrHinacxEgYa/Xksk+57zZ7yYH0AtB9F
         GyHwI/VMuiEFdTFmFr3TJZvovaPS4o9rAzlikv8Bl23dGV4/Zw0TjKxshaHc7WAhNvE0
         nt6+lCyyjplPFh4ix30GD9ZjlCOv1ZIi7XJI8aH/2n0tCfJ5OuCidSBidd12q7EV5+2U
         cJ+dO4pxxW21NEXrKcte93rgeX1Pm2QX1KX5WN45QhA+z6uqpNPXvBe2Ip0DYmPWf7+X
         3+8pqphySp8b2oCSGCRaORkgkz2TVZxGW3xWWy17h1YyhZqmXI/Ip5ykVP4iRMp9W5Nd
         Xh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589233; x=1791194033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mJTLKL9T8vepgzmrMMl9hUBXjorXrkUQap53+72PCy8=;
        b=GqXzVNfWPmxEOYSge4C29aNJ5LHnca2385LU9D+dHRRhx3YPdHRxGe6tt/CEYAJgPd
         EBEEXKyTS2h/msVigHRyYas07iScLtrbf0HtKUwUrdUVyrD58ZOQFsUEOH035/aBB5NS
         XMaNk87JW4VwD4qoE8A3RGKU+0nrdi/LsZyYELA1kFrIZzNqZApadwZB1bdetarSj1vT
         qMLr7ANTE7lZqYY2l4xoe2J2v0yFkslGzXlXqNqVJ1cWC/IE2qB2YMl8Fe13JhR1VvOf
         JPQaHzrGrHigwHPmcMiXhwN1booDfVIAWlxqUdyTpyXnwgaaijArDCPQBxafvBG0rM8L
         fudA==
X-Forwarded-Encrypted: i=1; AKwUvBzX79CSfOHxYSnyodMfqMh4iKl6w2tIueuxJ++88l+uHpvFYsI8B8/Zblint52yONPQRbMqH3FEkWyI/Nse@vger.kernel.org
X-Gm-Message-State: AFq9FYK1pnZ1oIWdAurJYaV1L2pxp8p0z2b9GyY5R+47JEdddwz4JXHG
	y1EWqj4YCyF6p93n4YCFITJzyllbqZTUf9SSJSnpQRHuK4p5h/jv3sp+
X-Gm-Gg: AYBFou2X7QnbrXA7s1Zf6spg3/Wdy8GFTfssbMs8ZL7zQtVMoaLUKCZa76Cl+89TmoM
	4eAW8rGfr+SxE3MyeyAqEENtjZiIfi7YjvRNmiPofbv8wtemo21ofHUcNUeFCr3tQXHOmHn5ZGl
	HTJuhEW3asIhaSNFvLh9JN0dr08cv//hF69xvF/f1T4iGlgm9KWg2ptLt+BZDkwi6s1YL143mKg
	XlUoBzevpphMsWy5J2OG9n+SSQFhRXCmNMD7tV4r9VA1acJVuhlTrbteXS6dIYPwRhkcjdazPSi
	hencPuAQLAINJQbdPX9OVDcvIyHbzetGB9IezhXWgvuY/hGBSHk2wGBn9w0kVCCieE/klkkMqEz
	nOV7F4UQeOgFWK8+WU76n+6y9b0HoaJY10H8VdMXA0L+67F2WPvZK0yIFhcPzVYf02/AS0WSTtn
	q0boRRdarXj/xc2yg+WhJtC7CAhZ9a2Bmf+Fc=
X-Received: by 2002:a17:906:2083:b0:c2d:5ce0:1061 with SMTP id a640c23a62f3a-c2d5ce01e9cmr243001866b.21.1790589233412;
        Mon, 28 Sep 2026 02:53:53 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678c90csm466121166b.6.2026.09.28.02.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:53:53 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 28 Sep 2026 11:53:51 +0200
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
Message-ID: <aro5L-W-439tTICi@milan>
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
 <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
 <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev>
 <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev>
 <aq1noAdz9U3tXH_Y@gremlin>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq1noAdz9U3tXH_Y@gremlin>

On Fri, Sep 18, 2026 at 05:35:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> Looping in Ulad who is best placed to respond on this.
> 
> Ulad could you look at the below? Thanks! :)
> 
> On Thu, Sep 17, 2026 at 10:32:48AM +0800, Hao Ge wrote:
> > Hi Suren、David、Lorenzo
> >
> > On 2026/9/17 09:12, Hao Ge wrote:
> > > Hi Suren
> > >
> > > On 2026/9/17 03:07, Suren Baghdasaryan wrote:
> > >> On Wed, Sep 16, 2026 at 9:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >>>
> > >>> On Tue, Sep 15, 2026 at 11:00 PM Hao Ge <hao.ge@linux.dev> wrote:
> > >>>>
> > >>>> Hi Suren
> > >>>>
> > >>>> Thanks for you review.
> > >>>>
> > >>>> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > >>>>> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
> > >>>>>>
> > >>>>>> The reservation is already stored in the maple tree when
> > >>>>>> vm_module_tags_populate() fails. A failed load never unloads the
> > >>>>>> module, so nothing releases the entry. Release it and roll
> > >>>>>> module_tags.size back. Without the rollback a concurrent load that
> > >>>>>> already passed needs_section_mem() can reuse the freed gap, skip
> > >>>>>> vm_module_tags_populate() and write to unmapped memory.
> > >>>>>>
> > >>>>>> vmap_pages_range() may have installed some PTEs before failing. A
> > >>>>>> retry to populate the same range would BUG on them, so undo them,
> > >>>>>> but only if vmap actually ran.
> > >>>>>>
> > >>>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> > >>>>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
> > >>>>>
> > >>>>> If a patch fixes two other patches, it likely needs to be split so
> > >>>>> that each part fixes one patch only. But read on please. I'm not sure
> > >>>>> if one of the fixes is correct.
> > >>>>>
> > >>>>
> > >>>> Kept them in one patch because they only make sense together.
> > >>>>
> > >>>> After a failed populate the reservation is released and the
> > >>>> size rolled back, so the next load takes the same gap and calls
> > >>>> vm_module_tags_populate() again, and that retry would trip over
> > >>>> the PTEs the failed vmap left behind.
> > >>>>
> > >>>> Without the rollback a load that already passed needs_section_mem()
> > >>>> just reuses the gap, skips populate and writes to unmapped memory.
> > >>>> So splitting them leaves each half broken.
> > >>>
> > >>> Yeah, that's why I think vmap_pages_range() cleanup should be a
> > >>> completely separate patch with vmap_pages_range() doing cleanup
> > >>> itself.
> > >>>
> > >
> > > I think I get where you're coming from now.
> > > Thanks for taking the time to explain.
> > >
> > >>>>
> > >>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> > >>>>>> Cc: stable@vger.kernel.org
> > >>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > >>>>>> ---
> > >>>>>>  mm/alloc_tag.c | 10 ++++++++++
> > >>>>>>  1 file changed, 10 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > >>>>>> index 2070e682fe10..95ddf5b743d0 100644
> > >>>>>> --- a/mm/alloc_tag.c
> > >>>>>> +++ b/mm/alloc_tag.c
> > >>>>>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> > >>>>>>                                      next_page, PAGE_SHIFT) < 0) {
> > >>>>>>                         release_pages_arg arg = { .pages = next_page };
> > >>>>>>
> > >>>>>> +                       /*
> > >>>>>> +                        * vmap_pages_range() only runs once all pages were
> > >>>>>> +                        * allocated, and it may have installed some mappings
> > >>>>>> +                        * before failing. Undo them.
> > >>>>>
> > >>>>> If vmap_pages_range() failed to map the range, why should we need to
> > >>>>> undo it? If it indeed leaves some partial mapping when failing then I
> > >>>>> would argue that vmap_pages_range() should be undoing these partial
> > >>>>> mappings itself before returning the error.
> > >>>>>
> > >>>> Yeah it does - none of the paths under vmap_pages_range() undo themselves on error.
> > >>>
> > >>> Hmm. I wonder if this behavior is intentional or requires a fix. The
> > >>> only possible reason I can think of is performance but I can't imagine
> > >>> a failure to map is a performance-critical case.
> > >>>
> > >>> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
> > >>
> > >> Huh, my gmail thinks you are still at your previous companies :)
> > >>
> > >
> > > I manually fixed it on the mailing list for this thread.
> > >
> > >>> guys think? Shouldn't vmap_pages_range() undo its possible partial
> > >>> mapping when it fails?
> > >>>
> > >>>
> > >>>> pcpu_map_pages does perform cleanup on its own as well. There may be other similar sites.
> > >>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> > >>>> so I did the same here.
> > >>>>
> > >>>> If we really want vmap_pages_range() to handle this cleanup internally, I believe that would
> > >>>> be a relatively large change, and we would need to consider many more cases. So I think we keep
> > >>>> the current behaviour for now.
> > >>>
> > >>> Yeah, I understand it would require a deeper cut but if that's the
> > >>> right way to handle this we might as well do that. Let's see what MM
> > >>> folks think.
> > >>>
> > >
> > > Sounds good to me. Let's wait and hear what the MM folks say.
> > >
> >
> > I just looked into the call sites for __vmap_pages_range.
> > And I found there's a bug in one vmalloc caller [1].
> > When gfp_mask has __GFP_NOFAIL, the code keeps retrying
> > __vmap_pages_range. If there are leftover PTE mappings,
> > this can trigger a BUG(); [2]
> > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L3946 [1]
> > https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L121  [2]
> 
> I think best person to look at this is Ulad as vmalloc is his baby :)
> 
> Ulad, what do you think?
> 
> Thread is at
> https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/ for
> context.
> 
Uh.. I missed this. Let me check!

--
Uladzislau Rezki
