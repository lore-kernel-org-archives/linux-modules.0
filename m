Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C201AAE09;
	Thu, 14 Nov 2024 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625572; cv=none; b=m2lG4I1qEwCN2IGqq5QgzRN4JjatmdDMvSl92D1kYB48r0vMOxWDAW0PL0OwaHMliLASW5nPzsY9z03NgtF0IU8cnGXg29XL96HTi3ij+113ZJSHj9bghHOGLNpV+8MeJz5E/rtgaSA4sHp57Cj873ByQ/a+Yx0HH7DiaMaZP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625572; c=relaxed/simple;
	bh=wJRI4xRgfrY5VJtpilmqM1Vwv/3NX00NFAlgM7B7LDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CONUrXnMQ4dbQTUjK44hxSXDA1boZF9NFdGHF0+feU+9Nrx+o5JPwIPu1J+UHNGhstZycZW9GC04H0jcQBsxh7oUcGygwWJgXbJmduYKwRaBMvHobKOtKbFLRJs8ugpUMl9m147RY1ku7DWSzzK4Fd0ab3d9smaQesuMwbZ2wTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L02ZK0hD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L02ZK0hD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BMw6PwJjMCAqkTCSaxzZzLEVq3+qMUjiYZSRnnbvSGE=; b=L02ZK0hDEjOAJgWyLmqZfn5jSl
	l2eT9/x09ihmINDRKWPcXETLH+EoPSZwe4Db3gl7/yhbbp5pyAV4o0ERRQjAaMvVSZPCl6GnfsZxx
	1NphBqE1zGY0LxaASbtZfb+4fENp5tImZDJzpjGQwVUgcv3IHrwHwVhKjI9sa/2MXRj8bxkYnVqtw
	LfCY0eFbrBEVF7sBJjtw8X9xkBdEReU5pkA+yutExuolXP/PqO2S2vWlist881rooYc4qJlEIFZ0P
	i8+TYDMZW+P6dp4KuwXZUhEWXYr41RZUJe0HzXjf8Gg4pmDsOL1Xwzi6iC3yoro+btycNH3E6n0lL
	GvJQTx9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBiuX-0000000F78u-1Ply;
	Thu, 14 Nov 2024 23:06:01 +0000
Date: Thu, 14 Nov 2024 23:06:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aaron Rainbolt <arraybolt3@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <20241114230601.GO3387508@ZenIV>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-6-ukleinek@kernel.org>
 <ZzYgrc4cNqlhezCs@infradead.org>
 <20241114131843.0df6a5a2@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114131843.0df6a5a2@kf-ir16>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 14, 2024 at 01:21:41PM -0600, Aaron Rainbolt wrote:

> binary you get after compiling and linking. It looks to me like this
> patch will prevent users from compiling Tuxedo's modules for personal
> use on their own systems though. I personally dislike that for ethical
> reasons - I should be able to use whatever code I legally obtain on my
> system, and I don't like my use of Linux being wielded against another
> open-source project by requiring them to relicense their code or no one
> will be able to use their modules.

I would question the "open-source" part here, TBH...  I'm no fan of
GPLv3 (to put it mildly), but I really wonder if that use of said
license is in keeping with its, er, spirit.  Ironic, that...

Seriously, WTF had these folks had been thinking when they chose GPLv3
for a kernel module?  I'm yet to see any coherent explanation - and
the ones I have seen would be _really_ incompatible with the stated
goals of GPLv3.  To such a degree that I can't take them as anything
plausible.

Could somebody who'd been there at least explain the rationale for
the license choice made back then?
