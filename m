Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D738D6A5
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150446; cv=none; b=uGrByiajLpUBKaxMH0k2gbdPYRqtnxy59XYT4PpO2YaTJFjwA/jyJMLsqZbNkN8A4w4axpQS7MoLE2z4gzBBJb35x5OR/MMkL+Gozga8NnY8zJdJmVoPBmjZgviwY4sLokVPhPMkgaI6ZgMAaKyw0ABs26PKj/wdDC/U36I8+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150446; c=relaxed/simple;
	bh=1xrgyhnoPeWpQlJ3XfS+PaK67HHhvy64N+FepmYUwaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6eRdTgGwCk0iT1WZqKAEGbzTVW6uxVbpYftfdur3NoAmZ/W1eNHEqtRT7U7NL+zhDeQUtDokTppmU41bPVcqO4gBDLJ4on/DfW87b3/Kyl/EV8nVQ7/lEOibLHGMFST7W1bbfccEMmUa3AZJY75jGs+LdCbz6T0YjZy3Mqc1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1tjztiL/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1tjztiL/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b3YJMvH/gbG0VTYghOtySntLrY1eKOBJat/84P+wphM=; b=1tjztiL/CBq1l8FCALfCKIGNKb
	ZEM/VWzGdles13yCsGop0lCY+rqnMPr5HN8BL7DgoYj/zr3WZ7GVP9QJkvFkzYiyVQ4Fi+HhH75ph
	daYV0d9TSuzkHvsW2p1Q57uh4+B36tiUWrdLJE6FbpS4yrDNswSdnkhE+Vlw+tKMsFFf0XoJk8MO2
	OsMjDE48IpdNWcf+oiOFHjSlndJgb560tPRCNdcwhyX2cj0jzMHKV5mnmzeNFF9lsQRFX4NOWkHEu
	6b+Fav1XHs4Ci4FK9z+CZuxJ2jxuHOw0KNghSPf8vmRMi0q5dHvDqF3+xEfEnzltf5kVnUuOzvEBx
	mxeaoDRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxQj-00000009d4t-0NTt;
	Tue, 10 Mar 2026 13:47:25 +0000
Date: Tue, 10 Mar 2026 06:47:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, atomlin@atomlin.com,
	da.gomez@kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <abAg7Wgq6N49pezT@infradead.org>
References: <abAXjc6OihRcdoAA@infradead.org>
 <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org>
 <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org>
 <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
 <abAdr6zqeqSNMJ8X@infradead.org>
 <CALOAHbCmxa0ptYTcq1EjRKMrzvFHCyyrv8CeEDYOhuuo7-QbOw@mail.gmail.com>
 <abAf5ZtiQGFoOQvT@infradead.org>
 <CALOAHbCg=nmwtoaMJj1KpeGqAXEuuAdnW+RCbe5KXxKKYGozzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCg=nmwtoaMJj1KpeGqAXEuuAdnW+RCbe5KXxKKYGozzA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 09:44:56PM +0800, Yafang Shao wrote:
> On Tue, Mar 10, 2026 at 9:43 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 10, 2026 at 09:35:23PM +0800, Yafang Shao wrote:
> > > > Why would that matter?  You don't get a wild card to do things otherwise
> > > > rejected because you contributed something before.
> > >
> > > Could you please explain why I am being characterized as a "leecher"?
> >
> > Because you're adding overhead to the kernel for your out of tree code,
> > which only you and not the kernel project itself benefits from.
> 
> Why do you believe the kernel project cannot benefit from them, given
> that all module maintainers have acknowledged their value?

Because by definition it does not benefit from making life for
out of tree modules easier.  And I really don't get your whole
call to authority here, it makes hard for me to take you serious.

