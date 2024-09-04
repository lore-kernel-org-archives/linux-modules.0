Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F21E00BE
	for <linux-modules@vger.kernel.org>; Wed,  4 Sep 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467879; cv=none; b=ctOV/u0PiZfpuwl0T3qkC7vblgMB1jA7tnTpD2p4mble7w/OmL6ayM3HHN34zd8xE5meb2NMryOdyre/ylqzYl3i83f3ROuyvaXbAwL+FR8jn6qKg3gySJlKysM9QFqzaDohkmp3qhZGyuVwUr2G+8FQRkLWGY/6e/iEo+u6K2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467879; c=relaxed/simple;
	bh=Kai+oXgyYqx51OC9L3hBXB9yZXTbTfdql5NHmBr+XLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih90TN7cUYhxFQfNV3GbZBJcZo1bVCyjiLIcqFxZq1lxjfwtYEpGkB4UjWLHsmubuheZxg0jR78mB3EIGjYUHaPu1A2GlM86PJ9uozfyACGnibOqlNHwME7e3nNBvUZgZc7fmVWjSCEeIs/92oaPtAcNrDPl2lqenTzdpTV4QCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OVf3aPck; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OVf3aPck"
Date: Wed, 4 Sep 2024 12:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725467874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJRjlFiLzX37Eyl/RAVDP2lOWHI5udCI3PpG5m3qNKk=;
	b=OVf3aPckmjLImnybBd3QJgZuv7Miwlfaa94VmAQuQD04yHk60dretbmCqlve+1G/hsasxU
	Y8H25oJcGNPfl1I9RdYkCpGecTN27Pjka5vkEHBD+xfaUftddGMVYu7nSzVLOPA9DDdoiG
	cP1SfjL7lUi09m9XTGkEI6mdw0YL+Ls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <keaqrfkkoswtpbtvr3l5oetd4d3ncbpaxsay7dckn74qdob2u2@lohq26fuccib>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
 <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
 <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
 <ZtiMZWqht_8Bse-5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtiMZWqht_8Bse-5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 04, 2024 at 05:35:49PM GMT, Matthew Wilcox wrote:
> On Wed, Sep 04, 2024 at 09:18:01AM -0700, Suren Baghdasaryan wrote:
> > I'm not sure I understand your suggestion, Matthew. We allocate a
> > folio and need to store a reference to the tag associated with the
> > code that allocated that folio. We are not operating with ranges here.
> > Are you suggesting to use a maple tree instead of page_ext to store
> > this reference?
> 
> I'm saying that a folio has a physical address.  So you can use a physical
> address as an index into a maple tree to store additional information
> instead of using page_ext or trying to hammer the additional information
> into struct page somewhere.

Ah, thanks, that makes more sense.

But it would add a lot of overhead to the page alloc/free paths...
