Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9631878
	for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061281; cv=none; b=DTqHQ+7znyvrc4gclu6ephDgIJb536lBBFvjEYF62ydTvckZGtrArFnYydDLho8sh/X97d6br+pqnWFMUZh5IoDsT+uT1pvYrW03O7XiLrWczGO14Wvxkuk3R7F0LAZ7/O9lMPGz2a3YDl+iejEEPqpCwlGyD2XdeyPJPxho/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061281; c=relaxed/simple;
	bh=EwwVucOL3SWalyTW56zmelV6w60sbsIsKcfCIBixIWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDWT+AL4THzpljyiIJmLVI1iiU5iM6PhdnUOcAmcSydUxH1DI3gzgxCEQsJUxnABYOb7wu+zAgGxM9V2F1isROukvPVI3x+6SWcEnE1kaPjicXMZ9h4Y7u33uYOjYDBhriOlnXLvp6lintsbft5u4VkGQmfbxIq+SMZ3byOAVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d72K/5/g; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d72K/5/g"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1615818276.1
        for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 15:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711061278; x=1711666078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZUn+CabKddPK7NEf/S7R2Utterh/ASXmWz24mderPg=;
        b=d72K/5/gg02ekOTLdcmZXuILhD4E+SE8cHOLcn4Rej9wDqOU+FQqtvl6YVkbvHnZ29
         w/kj3gr+fWjh50hW7Tkpq+V7NpHv3XyKQp87vVkzJeh4w5EZ3Knm8QVyS1/5ypQARR9w
         1KJb7gOszrUBmBsOc7eCRlNBDdL8rM/dnx57+35g2q+dd8yoL40qloe6EYxOH9fcaz4I
         ARqgtSuNyVxVdHKNYrm+3ON8iTZ1qss0xkRshyoQFvuRwHUs22LGBuwdb4jTlLSj9GPN
         QEBGWnLJQ+57swQ+kqY8L250sIVW1Qcl9AKcXM/xzmx8Vo43q0p0dWT4ka1FSaIwnTmm
         xOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711061278; x=1711666078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZUn+CabKddPK7NEf/S7R2Utterh/ASXmWz24mderPg=;
        b=PbEiCax1HL1TG/s/V+Bmh+D4pts6ATNH9lOC/hSiHgDvM2+J7DiLncMWGDkr3OY1aH
         QCi6qyALZSnEaavisrzPdCdY7ZXwNscKeYBn/JTzi1BatSUzT5kFBOCFnc+cU2A4SucU
         aBYd6LTfJOwsZ/RbHpN4y/p4EabJgWG/DG0OxEfzcFJUM047ZkWPA3tHyLrANhRt5PHK
         8s3Nj3vxr1DhFXuucYQ3rz+ktCwEWoPEKvFZbp1mN6FgE3JzK75ntKmIJpKCeKvI56ci
         PF6ILp4O88N4KK37Gi3QbqhY8hre+NP7UWdvHgW8oWG3nH08LeCnnTN4/29T5L9mTSQo
         y8ew==
X-Forwarded-Encrypted: i=1; AJvYcCUY79V0dRCwgcJJ2bXuide0VHJq6JjDFXPYhTnZMWjpbnWfHw3PFBkTTdCEKx/Ioa5ljG/O4V5fSO3ry/CBZfH2qlTQ/ShH/QYmMr1eoA==
X-Gm-Message-State: AOJu0YzLlXLVL7Gol0ZfKN7b16KMuniTnsjwCiIWzCbqcnEopxfHXbfH
	whzeA3t0ze+wJpHUVjeLsCmC4uoq8wIiYf8FyIeRrP6REbLy3hRDX1YNO0/hyFqbXJhTaW5g4/X
	7LUIegHMZZMvyvBGEhI37R4rf5BttN2c1wVPJ
X-Google-Smtp-Source: AGHT+IGTw1XuAorKpNX3Gh3/aZ4ugL4PM6jVqN6SCRojDxfSlrpu19ifc/cFi9jRyUBtPtqG+w5x/ZJTfS8KJ2Dmf6E=
X-Received: by 2002:a25:8047:0:b0:dda:aace:9665 with SMTP id
 a7-20020a258047000000b00ddaaace9665mr551844ybn.60.1711061278005; Thu, 21 Mar
 2024 15:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-6-surenb@google.com>
 <20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
 <gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
 <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org> <bliyhrwtskv5xhg3rxxszouxntrhnm3nxhcmrmdwwk4iyx5wdo@vodd22dbtn75>
In-Reply-To: <bliyhrwtskv5xhg3rxxszouxntrhnm3nxhcmrmdwwk4iyx5wdo@vodd22dbtn75>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Mar 2024 15:47:44 -0700
Message-ID: <CAJuCfpEO4NjYysJ7X8ME_GjHc41u-_dK4AhrhmaSMh_9mxaHSA@mail.gmail.com>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:17=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Mar 21, 2024 at 03:09:08PM -0700, Andrew Morton wrote:
> > On Thu, 21 Mar 2024 17:15:39 -0400 Kent Overstreet <kent.overstreet@lin=
ux.dev> wrote:
> >
> > > On Thu, Mar 21, 2024 at 01:31:47PM -0700, Andrew Morton wrote:
> > > > On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > >
> > > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > >
> > > > > We're introducing alloc tagging, which tracks memory allocations =
by
> > > > > callsite. Converting alloc_inode_sb() to a macro means allocation=
s will
> > > > > be tracked by its caller, which is a bit more useful.
> > > >
> > > > I'd have thought that there would be many similar
> > > > inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inode(=
).
> > > > Do we have to go converting things to macros as people report
> > > > misleading or less useful results, or is there some more general
> > > > solution to this?
> > >
> > > No, this is just what we have to do.
> >
> > Well, this is something we strike in other contexts - kallsyms gives us
> > an inlined function and it's rarely what we wanted.
> >
> > I think kallsyms has all the data which is needed to fix this - how
> > hard can it be to figure out that a particular function address lies
> > within an outer function?  I haven't looked...
>
> This is different, though - even if a function is inlined in multiple
> places there's only going to be one instance of a static var defined
> within that function.

I guess one simple way to detect the majority of these helpers would
be to filter all entries from /proc/allocinfo which originate from
header files.

~# grep ".*\.h:." /proc/allocinfo
      933888      228 include/linux/mm.h:2863 func:pagetable_alloc
         848       53 include/linux/mm_types.h:1175 func:mm_alloc_cid
           0        0 include/linux/bpfptr.h:70 func:kvmemdup_bpfptr
           0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
           0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
           0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
           0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
           0        0 include/linux/bpf.h:2249 func:bpf_map_kvcalloc
           0        0 include/linux/bpf.h:2243 func:bpf_map_kzalloc
           0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
           0        0 include/linux/ptr_ring.h:471
func:__ptr_ring_init_queue_alloc
           0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
           0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
           0        0 include/net/tcx.h:80 func:tcx_entry_create
           0        0 arch/x86/include/asm/pgalloc.h:156 func:p4d_alloc_one
      487424      119 include/linux/mm.h:2863 func:pagetable_alloc
           0        0 include/linux/mm.h:2863 func:pagetable_alloc
         832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode
           0        0 include/linux/jbd2.h:1591 func:jbd2_alloc_handle
           0        0 fs/nfs/iostat.h:51 func:nfs_alloc_iostats
           0        0 include/net/netlabel.h:281 func:netlbl_secattr_cache_=
alloc
           0        0 include/net/netlabel.h:381 func:netlbl_secattr_alloc
           0        0 include/crypto/internal/acompress.h:76
func:__acomp_request_alloc
        8064       84 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
        1016       74 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
         384        4 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
         704        3 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
          32        1 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
          64        1 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
          40        2 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
          32        1 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
       30000      625 include/acpi/platform/aclinuxex.h:67
func:acpi_os_acquire_object
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:67
func:acpi_os_acquire_object
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
         512        1 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
         192        6 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
         192        3 include/acpi/platform/aclinuxex.h:52 func:acpi_os_all=
ocate
       61992      861 include/acpi/platform/aclinuxex.h:67
func:acpi_os_acquire_object
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 include/acpi/platform/aclinuxex.h:67
func:acpi_os_acquire_object
           0        0 include/acpi/platform/aclinuxex.h:57
func:acpi_os_allocate_zeroed
           0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtable_=
page
           0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtable_=
page
           0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtable_=
page
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/hid_bpf.h:154 func:call_hid_bpf_rdesc_f=
ixup
           0        0 include/linux/skbuff.h:3392 func:__dev_alloc_pages
      114688       56 include/linux/ptr_ring.h:471
func:__ptr_ring_init_queue_alloc
           0        0 include/linux/skmsg.h:415 func:sk_psock_init_link
           0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
           0        0 include/linux/ptr_ring.h:628 func:ptr_ring_resize_mul=
tiple
       24576        3 include/linux/ptr_ring.h:471
func:__ptr_ring_init_queue_alloc
           0        0 include/net/netlink.h:1896 func:nla_memdup
           0        0 include/linux/sockptr.h:97 func:memdup_sockptr
           0        0 include/net/request_sock.h:131 func:reqsk_alloc
           0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
           0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
           0        0 include/crypto/hash.h:586 func:ahash_request_alloc
           0        0 include/linux/sockptr.h:97 func:memdup_sockptr
           0        0 include/linux/sockptr.h:97 func:memdup_sockptr
           0        0 net/sunrpc/auth_gss/auth_gss_internal.h:38
func:simple_get_netobj
           0        0 include/crypto/hash.h:586 func:ahash_request_alloc
           0        0 include/net/netlink.h:1896 func:nla_memdup
           0        0 include/crypto/skcipher.h:869 func:skcipher_request_a=
lloc
           0        0 include/net/fq_impl.h:361 func:fq_init
           0        0 include/net/netlabel.h:316 func:netlbl_catmap_alloc

and it finds our example:

         832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode

Interestingly the inlined functions which are called from multiple
places will have multiple entries with the same file+line:

           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc
           0        0 include/linux/dma-fence-chain.h:91
func:dma_fence_chain_alloc

So, duplicate entries can be also used as an indication of an inlined alloc=
ator.
I'll go chase these down and will post a separate patch converting them.
