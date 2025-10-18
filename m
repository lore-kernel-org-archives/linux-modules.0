Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375A153BE9;
	Sat, 18 Oct 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760826472; cv=none; b=tXNTpJ7HY/PaX7AWS/TD+UERgCh8YYdAUFAoEKWgP4gFyKM9ddQneLFb2j2pOAikX13TfxDDtxCLfr5Odrkg7nIXaoefT2zV2mnvLJL4NNCH1uSRJUtbjVKrVBmCOV9mX+OGtnBKZHYUaN5sTIFOWcLf9CyWPYotAa3quMPPsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760826472; c=relaxed/simple;
	bh=sv55VBMfMxRR0VQ7gXEeKljTKIrmjOAIjER8VzsG7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAM4fYdZ+fRb1k6vfK2UH3G9yUjf2E0a9KLCfsdOu35Hi0r68qcL1MLzcIXJAVoLd8V4LS6In8kt8T4v3dK9i/ofl1oFqeXhzyZJO1wHa0GNELxrPyUyE/2coWRuKOn2K2VFeJNfLiZcGxqlmd21eZsLBv56Z1WQFc3E8VapVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg8IHfDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg8IHfDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE64C4CEF8;
	Sat, 18 Oct 2025 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760826472;
	bh=sv55VBMfMxRR0VQ7gXEeKljTKIrmjOAIjER8VzsG7IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cg8IHfDZT5NlqwmaxIxGP7+c61M1faD2yZBu22fqGNC3AfRZhJ210HO/uFVYQ06xn
	 nIsXygxvdkgjFtYqglL64iW2PXYVqgc8sg3kXWgFg78Yf2UFhak9wotfBUUeaW2vKI
	 qb6AQn8ukPWFvAyGOmYA9Nvx6+AtpSQbZ2FQ85TkAnwhKle6cP2oyzfqb3cJulCNdF
	 4HaegnRQqZPdhacJ2CsnwnpQi130ojFXubVt2JuO8BXaECmDdwCMqDy1KcPz4M5/5/
	 tbZPVBg1XYIwK5sf00/fAQhBKroU8pzAIVdhb2Xfe6txwEqCnICuvuC1xhsFGd6amM
	 F1CnDwKfUFi4A==
Date: Sat, 18 Oct 2025 15:27:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for module support
Message-ID: <aPQUZvpnYPVdVJOv@bombadil.infradead.org>
References: <20251018180210.347619-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018180210.347619-1-atomlin@atomlin.com>

On Sat, Oct 18, 2025 at 02:02:10PM -0400, Aaron Tomlin wrote:
> Voluntering as a reviewer for Module support.
> 
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Even though we have 3 others working on helping with Rust, it turns out
its not enough and so this help is greatly appreciated, thanks Aaron.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis
