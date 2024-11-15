Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B418FC74;
	Fri, 15 Nov 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662342; cv=none; b=E1mlWBp5Q2jEU0kjSaU76+cYZhRFbTvm8weKnI1ASF97KEpa8n3qOL4jMTDF0QUwW/2zs7trLP2WgLJKtmOhUJGP1zligNEm4t32aJkhQl4XeaHF9f1gtveqGpvoi2FyjAQ62Npji25tnXBE9qVSJXb9kHNYvcv+3B3QdnpuBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662342; c=relaxed/simple;
	bh=2CrEnw4sm8gG9cJ/ZIRSkl7D/V40SW+5nE+VvtAcwgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jazGoiqe5d+lIoFGKoOnQZyC6LsQL+YhrjzdVo3HwzqVSr6HerTelTF8viARzzU6CF20W2gIuxkEAycQztcS5ucJgpgA+iN2DMYbQutQk6Tjh273uCGqLdXCxpjaf7nSuAV4z5PL7BHrXKUEwqVUl2cb5uErBULCdo0q9W/vda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qzf5wSPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzf5wSPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB36C4CED4;
	Fri, 15 Nov 2024 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731662341;
	bh=2CrEnw4sm8gG9cJ/ZIRSkl7D/V40SW+5nE+VvtAcwgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzf5wSPSqM0Du5+dIZzmcCCAc+BrBHKg7DDRB1wmD6UcTrOIgg7M6Wp6EGLWMQzo8
	 91zVR4v9Hp9bzHDx3y406C00p5ykL/fe97e28G9ZyBNVrB/E6fbDu3OWJslDsP5sW2
	 Bg9uZOhM83aTRxnQQ2fas93JXfMD1GSHQyXtf4ls=
Date: Fri, 15 Nov 2024 10:18:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Vinzenz Vietzke <vv@tuxedocomputers.com>,
	Christoffer Sandberg <cs@tuxedo.de>
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <2024111522-brush-excusably-cae5@gregkh>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
 <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>

On Fri, Nov 15, 2024 at 10:00:23AM +0100, Werner Sembach wrote:
> I guess what I try to convince you and others is that we _are_ taking Open
> Source licenses seriously, but still there are mistakes to be made,
> especially with complex projects like the Linux kernel, e.g. I'm not aware
> of any other project that uses a similar construct to
> EXPORT_SYMBOL_GPL()/MODULE_LICENSE().

The Linux kernel is very simple from a license point of view, your code
has to be GPLv2 compatible.  That's it, nothing complex or odd about
that at all.

thanks,

greg k-h
