Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF827A137
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241820; cv=none; b=Vnnh6aOmXPZ4f+LWZ/R3em4b2m2OrEmiFv5zM6780kxzk6R/05twX3k8VNM1PTCAtzNZjJFcnhVjO/d1F9ovTwjhbJC5wxS4oYpHS+ocLASJfNkfqmTkDKU+XqpfhiAI9kDA7k4OZIN8oTov3j976ZBv3QqQTUTnVOgml6yeHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241820; c=relaxed/simple;
	bh=j3LsEv6zAG5BsGwFMa43nOdKxce61E7HPZutt0VNDRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8cZlnlQbpSmOU6b2hinqM2STwJpjSGAz7Lxtf+P8PukiX5UfxkwZiZAEnaTI0bjoki+SFeK+QvZqxejEVJnXrEup4nec49tIqnIvkCzQBJKkcVyASSNvHqinrNMsk/HKosZwpIx8K93niIoyC0Q6OCRr3ApERcio+0VjAsDbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAVEEbeu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAVEEbeu"
Date: Wed, 14 May 2025 12:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747241815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PitS4W388Eigg05a5/D0HAoDz3yzgmvZnFZpVitTBk0=;
	b=HAVEEbeuQWrb3MR6DTDdIng7sSPKkQRDqO7HffwW4a2XDC3f7kaEJghMudZYYY4icsSlxb
	IPVkiPb1o4c5XlMikOx7aBQxBybm3LGJT3LDZawyHxMssbHat4nSysUZKy9L2K5nLhGIeT
	ImGnfZ74c2kAnBITDLdsJdrYozdQRXE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH] params: Add support for static keys
Message-ID: <oepzs4fbygpbbjq5icrxpsvn6jpsrzghnt76rjmnyw7o35pbdl@2yjw6pxng5ay>
References: <20250510210126.4032840-1-kent.overstreet@linux.dev>
 <a4700ad8-1e6d-4f57-b160-e7b6d172ef60@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4700ad8-1e6d-4f57-b160-e7b6d172ef60@csgroup.eu>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 07:51:57PM +0200, Christophe Leroy wrote:
> 
> 
> Le 10/05/2025 à 23:01, Kent Overstreet a écrit :
> > Static keys can now be a module parameter, e.g.
> > 
> > module_param_named(foo, foo.key, static_key_t, 0644)
> > 
> > bcachefs is now using this.
> > 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Daniel Gomez <da.gomez@samsung.com>
> > Cc: linux-modules@vger.kernel.org
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >   include/linux/jump_label.h  |  2 ++
> >   include/linux/moduleparam.h |  6 ++++++
> >   kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
> >   3 files changed, 43 insertions(+)
> > 
> > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > index fdb79dd1ebd8..0fc9b71db56f 100644
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -107,6 +107,8 @@ struct static_key {
> >   #endif	/* CONFIG_JUMP_LABEL */
> >   };
> > +typedef struct static_key static_key_t;
> > +
> 
> Please read https://docs.kernel.org/process/coding-style.html#typedefs
> 
> I can't see the reason for a new typedef here. If there is a valid reason
> please explain in the commit message.

You can't token paste with a type that's two tokens - that's basic C.
