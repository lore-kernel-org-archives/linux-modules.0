Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166622F8E8E
	for <linux-modules@vger.kernel.org>; Fri, 26 Jun 2026 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458191; cv=none; b=mBUQ5bZW0aCpBEJCtre81q51no5AFSzo41faTqGSPxOVzZv1gr4kYGBCTFdPLEWyB5Tu78bAhtDU5sQwkgsW46TxZPLSY6CR8KvbyDUdXkkcUnfnyALlF/qQLAFfh890M4p9ndmKGk1q4uebrBAqxbRJlsH0enkCMrVC774JgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458191; c=relaxed/simple;
	bh=MSmiIsEcg2IkVuGNreIcL08t4sukKxL7P2IxBAGPr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQKT1ZtS81XReCxgNZvukQr48fVhIJmEMMsYDrjfuaT4xVB4XDveytTGmH+sqTZswYcgv0LCJAjHFidHykAlgURw6r/1wRRyf0YruF/Cnvk85Dj0N5VzVQT6bNIpvcsNBCNPrDtclv/4i3rPdQDDK1gowq+W9QEbPsbv1lAYxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwjDCCsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwjDCCsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A8B1F00A3A;
	Fri, 26 Jun 2026 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782458190;
	bh=UiLj2S+WxQF+JLgvXz3k9AyDmxeBJNqtq/RIlvOkJEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AwjDCCsWsUf+667k5JeIP5r7fBqdf8qUn5c4PGUCqx8dYv7Arc1BrIoy9OxulOtr0
	 gvdpQteAn2oOkW87RjQKY07nGRSlMV4Rgnep5ZT5i6UVAhZXfgFwmSeWM0h6RV9Huc
	 OlA6/w+zmxQNhEwwsEIjMFGeN7vCxrMvHqXSjrtI=
Date: Fri, 26 Jun 2026 08:15:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, atomlin@atomlin.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <2026062645-entryway-zen-c230@gregkh>
References: <20260310023807.80140-1-laoar.shao@gmail.com>
 <aa-6wILF90Y4ndnd@infradead.org>
 <20260311224420.GB2440964@google.com>
 <CALOAHbBQhOsNVemgdtj2qLMN=bwqpE89ySqgLOMa9DY3-K4y7g@mail.gmail.com>
 <CABCJKufaZMfhRFu-FJj6eHgEjkxmhPYpxMoiYMyp1U0j-f5RJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKufaZMfhRFu-FJj6eHgEjkxmhPYpxMoiYMyp1U0j-f5RJg@mail.gmail.com>

On Thu, Jun 25, 2026 at 06:12:43PM -0700, Sami Tolvanen wrote:
> On Wed, Jun 24, 2026 at 7:49 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Just a friendly follow-up. I noticed that this patch hasn't been
> > merged into linux-7.1 yet. Could you please let me know if there are
> > any further actions required on my end?
> 
> Based on the discussion here, the consensus seems to be that module
> versions do not make sense in the mainline kernel and should be
> removed instead:
> 
> https://lore.kernel.org/linux-modules/2026031341-evolve-repeater-987b@gregkh/
> 
> This reminds me: Greg, would you mind sending v2?

Yes, it's on my TODO list after -rc1 is out.  Sorry, am on week 6 of 5
conferences in a row which hasn't left much time for new patches...

thanks,

greg k-h
