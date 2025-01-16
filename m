Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DF22C9E8
	for <linux-modules@vger.kernel.org>; Thu, 16 Jan 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041408; cv=none; b=VhBqL+Z+uzKSWE2StaXX+s7k7rrHylMIUSpRH5Kr/TwicYVNZuZ0l3cq4bu+o815tfWYuq/ugw3FwafMRvdiHTQutsVCaSxndOxYHcwn/tj1bbx5LcLF30d2vvMb1GOUZg9q5EIh5yMtX4HKq6wuiLuh3Fuv0pJqtPTmUMnrOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041408; c=relaxed/simple;
	bh=sj0Yk4R4Cn4AeEwULOafwSAY5++4IddS9XZdeLDoyyk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qiZ95kdSxqhEmHzoaZ6o7LBHOBckWOxqrK8JuJYwmHAQstibVRxwnKJktsNdVkN5UNtzcwNTHZ0xGoBuvQIGfj0gJCPuffyW6Pv7yr8oR7PQpa/r/2L+ZlGquuJccWWWCvgu3ZelXejZVi+wEVt2MoFUNZN/Vx22ZlWmIEI2iHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yr8ZoAae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr8ZoAae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737041405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEZB3oUMEGAnbbLJjY6iG6Vdp9wcrmp6p6+l59nQrbo=;
	b=Yr8ZoAaeRwns7Mv8HQxNcxptGTVj9/vayLL35ySP3+O2l19AgoR3UhD4A+rcgkg9jcYAbc
	cXK9x5HtfMYDAiTdVdmks4gu334TKZ0ixfTDjm7DiLkmc5C89x6kR+qnL9BbIVDRkaKnIS
	gUNujxNKGMe8PKN9PjR2L1CVv54TZnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-dQEdoyvfNSGQPpXF6Stagg-1; Thu,
 16 Jan 2025 10:30:00 -0500
X-MC-Unique: dQEdoyvfNSGQPpXF6Stagg-1
X-Mimecast-MFC-AGG-ID: dQEdoyvfNSGQPpXF6Stagg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E06F61955DC0;
	Thu, 16 Jan 2025 15:29:58 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0432819560AE;
	Thu, 16 Jan 2025 15:29:54 +0000 (UTC)
Date: Thu, 16 Jan 2025 16:29:51 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jan Beulich <jbeulich@suse.com>
cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
    Daniel Gomez <da.gomez@samsung.com>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    Helge Deller <deller@gmx.de>, linux-modules@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
    Sami Tolvanen <samitolvanen@google.com>
Subject: Re: Unaligned accesses when loading modules
In-Reply-To: <16bf04b0-64ad-4614-957e-2971f053949d@suse.com>
Message-ID: <0144332b-be9c-2f6d-81bc-a18f13990d65@redhat.com>
References: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com> <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com> <aedcb0fd-040b-0dcc-8c28-34a0b07d5a7e@redhat.com> <16bf04b0-64ad-4614-957e-2971f053949d@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811712-1062778216-1737041398=:159087"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-1062778216-1737041398=:159087
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 16 Jan 2025, Jan Beulich wrote:

> On 15.01.2025 19:02, Mikulas Patocka wrote:
> > On Tue, 14 Jan 2025, Sami Tolvanen wrote:
> >> On Tue, Jan 14, 2025 at 6:07 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >>> On PA-RISC, with the kernel 6.12.9, I get unaligned pointer warnings when
> >>> a module is loaded. The warnings are caused by the fact that the
> >>> .gnu.linkonce.this_module section is not aligned to the appropriate
> >>> boundary. If I dump the module content with "objdump -h configs.ko", I get
> >>> this. Note that the .gnu.linkonce.this_module has "File off 000042d2" and
> >>> "Algn 2**4".
> >>>
> >>> On x86-64, the same misalignment can be seen, but it doesn't cause
> >>> warnings because unaligned pointers are handled in hardware.
> >>>
> >>> This seems to be a bug in the linker, because when I compile an old kernel
> >>> with a new linker, I also get the misalignment. Do you have an idea how to
> >>> work around this bug?
> >>
> >> Does explicitly specifying section alignment in the module linker
> >> script fix this by any chance?
> >>
> >>> kernel-6.12.9, binutils from Debian ports:
> >>> [...]
> >>> kernel 6.10, older binutils:
> >>
> >> Which exact versions of binutils were used here? I don't see the
> >> alignment issue with binutils 2.42 on either x86_64 or parisc64, so I
> >> assume you're testing with something newer?
> >>
> >> $ hppa64-linux-gnu-ld.bfd --version
> >> GNU ld (GNU Binutils for Debian) 2.42.50.20240625
> >>
> >> $ hppa64-linux-gnu-objdump -h configs.ko | grep -E '(format|this_module)'
> >> configs.ko:     file format elf64-hppa-linux
> >>  17 .gnu.linkonce.this_module 00000300  0000000000000000
> >> 0000000000000000  00005c50  2**4
> >>
> >> Sami
> > 
> > Hi
> > 
> > I use version "GNU ld (GNU Binutils for Debian) 2.43.50.20250108".
> > 
> > It was broken in the commit 1f1b5e506bf0d9bffef8525eb9bee19646713eb6 in 
> > the binutils-gdb git and partially fixed in the commit 
> > d41df13ab36b224a622c0bdf28a96a0dee79db77 - the section is still not 
> > aligned at their specified boundary (16), but at least it is aligned on 8 
> > bytes, which avoids the warnings.
> 
> When you say "broken", can you please explain what it is that is _broken_?
> Things have changed, yes, but the produced ELF is - afaict - still within
> spec. The "partial fix" as you call it wasn't really a fix, but a band-aid
> for some broken consumers of ELF. Plus modpost, being one such example,
> was supposedly corrected already (Linux commit 8fe1a63d3d99). Said "partial
> fix" was also confirmed to help modpost [1] - are you saying that wasn't
> quite true?
> 
> Jan

By "broken" I mean that the file offset is not aligned to the section's 
alignment.

By "partial fix" I mean that the file offset is aligned to 8 bytes, but 
the section's alignment is 16.

When Linux loads a module, it takes the .gnu.linkonce.this_module section 
from the module file and points a pointer to "struct module *" to it (see 
"info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;").
So, if the section is misaligned, you get warnings about kernel accesses 
to unaligned memory.

That commit 8fe1a63d3d99 should have been ported to the stable kernels (I 
used the kernel 6.12.9 which lacks it), I'll post it there.

Mikulas
---1463811712-1062778216-1737041398=:159087--

