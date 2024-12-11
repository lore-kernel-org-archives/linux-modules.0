Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29F2AE90;
	Wed, 11 Dec 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891343; cv=none; b=Dhls3rZJUmmZCczS0aE+pyBqN68fWS5eNUcXM5GlECOTkT2YWcDIoyUEj8sca4iw5dydseoaCkxczHEbs/GrGYtiX9nzoHwccMuI3D0F5OqQrTiMLM1bkYckdYneqQgLEOhNnqz1E/zNT4f27If2YytAS+n9byjCC2/1nsv2J9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891343; c=relaxed/simple;
	bh=E1dy64TF2jE9VaJGfyq7vKYKplc7baGwNatUEErEEuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSGweWzF8Tq8eSST1Rg2Y8nwOIVavrIbvgr/dRuL0Pgy9NaKAznrWiDNBcng37dixV26HEIlVTqFNT0AOotEV3ilfPSnZlhpjUaHrWUQj5VRzSz/YNSnz76/5jLtkaAFzbuaea8mRXnJy4spy1k7HaRnO3wbcVddV5J9xbn1xBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o++OoVAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o++OoVAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F1C4CED2;
	Wed, 11 Dec 2024 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733891342;
	bh=E1dy64TF2jE9VaJGfyq7vKYKplc7baGwNatUEErEEuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o++OoVArxfvdrBv3oDLK4K2NYG+wiwiRqheMr+ju9Cc9CQroY3RX4PCQbbe4yCPac
	 AKT5tVN5BmMDc9f0OtIG694JrNz3aYUZTM9ZU0RXKKidj82Iu2+48giEkgOGnbGWqH
	 wbYGoh6ZV7cS2umWsJddD8XdljiEFj5IpJtrn4UipKjjcgX/fKqwfy/b4O+uCt2RPl
	 a6RaU1CxCNZ1c1xq5Q44XQQ7Jovu2OGbPrVz0yQOlZ/zySBut0fzm3qNwmQieE5uxK
	 ttr5Gap8iaB0fpenV5qy/CDtt9ikYnCmehlCbw2uFkqSxKY4boORG3EtL7NXsm3i2T
	 nbPoaMV/2Az/A==
Date: Tue, 10 Dec 2024 20:29:01 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Message-ID: <Z1kVDQXQYPrZYxuK@bombadil.infradead.org>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733427536.git.christophe.leroy@csgroup.eu>

On Thu, Dec 05, 2024 at 08:46:14PM +0100, Christophe Leroy wrote:
> This series reworks module loading to avoid leaving the module in a
> stale state when protecting ro_after_init section fails.
> 
> Once module init has succeded it is too late to cancel loading.
> If setting ro_after_init data section to read-only fails, all we can
> do is to inform the user through a warning. This is what patch 2 does.
> 
> Then patch 3 tries to go a bit further by testing the ability to write
> protect ro-after-init section prior to initialising the module.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
