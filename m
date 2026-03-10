Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1C392C39
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149617; cv=none; b=jcwdcaPF1qAYeYhDxNHaL97uYbclXGl/DWWUnwZFPvZ86Kgrr3zm0hS8CLMLCRYuv+s8f3pWHOO2qJB+cl1uEPwbNo4CSguGKjdtMpjB0UVCEcVGs/CA8AOA1Je4YlrC36yHRI+OKgpXicfY1xcOt91RG/Y9ZNMsg3Ch+yB/UeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149617; c=relaxed/simple;
	bh=ai8ntZYY9W2iWGKEzAdyl6RbrcttbNPuAFawBsxZT80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRTZ0F/Eb0Acq5k/kKO6gc978+4XYDPxHWmlxUnFGff1OgRUQDtbAhMX10nqUnCt4oHAy3SeCUgqJ97ct6gpe4H9Zh6KtEZPXPmQQum52Yvz5XSDW47zuhPM04ShiynDlRXJ0tPsLxU0BXEc0fdrjrpNlUauzcG8zJW8iBqKgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JAa6p9U6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JAa6p9U6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YC2F7d8QqRehaLfbdSj93ZCMW7m4XI+5zqSTKksOJAM=; b=JAa6p9U60TUZ6Wy3lmU5DHjIfJ
	jvQEYBJ0xghmrwoeevOfXpno6VfWNrBEuWXo3ccoNGAQMqvp42l77i2IqvI10X1f4bJxdSq7Vzziw
	njvClPJlesoSR78h+Fi/U+Ue2YMt8bh0Z/+vIIhj67kmAWBU14LlNkqLfQeW5fBppoOy8StHqOjV2
	+x/fbo6Wa6k6I52MQ4qw7LuVrys2eH/wb5vaV/tJ8saidInKIxEJS4RbV41rMcDuAk5xVMJWCy8Cu
	nMm80/9VpmMAZK/0Lwpg5Z9QtKAwllx6NlG9EdWH0oZVtEDEpDId8e2En3gs/3Gf2ERGBb4crf3F0
	20H/Kegg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxDL-00000009beG-1jF5;
	Tue, 10 Mar 2026 13:33:35 +0000
Date: Tue, 10 Mar 2026 06:33:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, atomlin@atomlin.com,
	da.gomez@kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <abAdr6zqeqSNMJ8X@infradead.org>
References: <aa-6wILF90Y4ndnd@infradead.org>
 <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org>
 <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org>
 <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org>
 <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 09:30:06PM +0800, Yafang Shao wrote:
> On Tue, Mar 10, 2026 at 9:21 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 10, 2026 at 09:19:22PM +0800, Yafang Shao wrote:
> > > Given that the Linux kernel officially supports out-of-tree modules,
> >
> > It does not officially support them as a first class entity.
> 
> But out-of-tree modules are still a supported entity by the Linux
> kernel, correct?

They are not supported, and any support request that includes them is
typically rejected.

> > It adds overhead
> 
> Could you please explain what overhead this might introduce?

It adds code that needs to be maintained and which is built into every
kernel.

> 
> >  to the kernel just for leechers like you that don't
> > actually contibute their code upstream.  That's always a bad idea.
> 
> I am not the GPU vendor, so I am unable to upstream the relevant code myself.

Well, that's not the kernels problem.

> By the way, here is a record of my contributions to the Linux kernel
> over the past few years:

Why would that matter?  You don't get a wild card to do things otherwise
rejected because you contributed something before.
