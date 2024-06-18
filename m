Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1B15E5BB;
	Tue, 18 Jun 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740733; cv=none; b=pUy7Yw+ErAMzDBEmXHhd2X97hylfwIWLZR3zcvtL0JFAiFlSYIDRhQx/U194zZThcV4rWQ1E007M6oyVYQLpwEO6JQNtonXDCPYLpSoKB3Fs9q9L7ItYNjF4phnwdOmYBQxGYFc8Y7g++9y1j1FIQgn2yW1lGeYvuJD2yEQMSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740733; c=relaxed/simple;
	bh=pOll0MsKZ29ccv77vg/g9goYi2pOZHlxPoML9layKyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrU1ZBk5qC9Ge12YPgGEPJB9fucT5vCTi3fvlvUGCkOhUOdnaEzT2CqYoqCcbU7DKzyit5i4aOpVHFIaEyhDvSIYAqn3i4LHim9z9lavj/mkmtZhMJ1jxB7A48+CBHn3tUdd+4X1h/VhNgs24cj6v0C+HGAXuW7Xh0G95SuYXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u6Mt1Br1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u6Mt1Br1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9m5BEJrJxFveSDA9QcMruDPhf+MAQiYQqFwSF8+UNIw=; b=u6Mt1Br1UaOUWwddHMogoiLVL3
	SlLVnQjMWackza7E1KwkfkJfZGX1dBuz2gJMKBvATqQYPoj0qQDNAkf82Y0tQuUM3YxpdYpSTvO4p
	FviyhMLwBOxOl079PiEGlsjB+YoRodbNpXHG1qQLj8MA8JZVbL4E0n13ZjKJbwJXNvrGXDlqTzcHB
	XjRTg+1AbrwFcxOvlsgItjryFc4LzhjKVqWbxG/typndJLb5pFYfsfOeLNoa9wz/ugr32V8jdLt/F
	XKh8lGaUn4pwpTgneigJEJE/t+BLsvlF1QZNe1qehxM3m5hOxC1gtrdTGP4hXkovUk+6Acvxy1VWd
	F8Ki06UA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJeyh-0000000GQsc-1KiW;
	Tue, 18 Jun 2024 19:58:51 +0000
Date: Tue, 18 Jun 2024 12:58:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Daniel v. Kirschten" <danielkirschten@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10.0-rc2] kernel/module: avoid panic on loading broken
 module
Message-ID: <ZnHm-5oljP8_5dFB@bombadil.infradead.org>
References: <230772fc-1076-4afb-8f7a-e7c402548c3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230772fc-1076-4afb-8f7a-e7c402548c3b@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jun 06, 2024 at 03:31:49PM +0200, Daniel v. Kirschten wrote:
> If a module is being loaded, and the .gnu.linkonce.this_module section
> in the module's ELF file does not have the WRITE flag, the kernel will
> map the finished module struct of that module as read-only.
> This causes a kernel panic when the struct is written to the first time
> after it has been marked read-only. Currently this happens in
> complete_formation in kernel/module/main.c:2765 when the module's state is
> set to MODULE_STATE_COMING, just after setting up the memory protections.

How did you find this issue?

> Down the line, this seems to lead to unpredictable freezes when trying to
> load other modules - I guess this is due to some structures not being
> cleaned up properly, but I didn't investigate this further.
> 
> A check already exists which verifies that .gnu.linkonce.this_module
> is ALLOC. This patch simply adds an analogous check for WRITE.

Can you check to ensure our modules generated have a respective check to
ensure this check exists at build time? That would proactively inform
userspace when a built module is not built correctly, and the tool
responsible can be identified.

  Luis
