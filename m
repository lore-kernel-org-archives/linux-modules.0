Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794751E492;
	Thu, 31 Jul 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963435; cv=none; b=Uif7vLtRCGxgobMUprb5v1gHCsYTlpdaZYhGM9cl9t+nMXmeil04NoDb920VbXLJ1csECJ4SZBd9EGB6idhnfEdtTdD6DRfCLB/E0mYy+gwU8c148zZR4uKe2DF+n5qHGVD0Oobrf8k349MZ9o8RsmfivslQ11DRpqTQ+o7cE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963435; c=relaxed/simple;
	bh=CosuYs8ZAvd05NLXFJPuPdgvF7ECMTPOPZM/5p5FyEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADAKE2x3n5m1/OI+RkGpZWy5U7b3deWr6coGdUi6XO0f0b/YGDVqiiTMvB7kGvIpRJQfTNn7YquoRgOV9+BqtPPgyiBskzrCxR4m4UV0pGxggt+pd84FjaN4c1ZSKhk8ma2knFMba7vtQvJzYP7uyuXLsiNedlzqfqtuFVK/m+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC9C4CEEF;
	Thu, 31 Jul 2025 12:03:52 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630143535.267745-1-petr.pavlu@suse.com>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
Subject: Re: [PATCH 0/5] module: Fix minor problems related to
 MODULE_NAME_LEN
Message-Id: <175396343289.28568.3768250551713485412.b4-ty@samsung.com>
Date: Thu, 31 Jul 2025 14:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Mon, 30 Jun 2025 16:32:31 +0200, Petr Pavlu wrote:
> Fix a few minor problems related to MODULE_NAME_LEN and
> MAX_PARAM_PREFIX_LEN, and clean up their usage.
> 
> Petr Pavlu (5):
>   module: Prevent silent truncation of module name in delete_module(2)
>   module: Remove unnecessary +1 from last_unloaded_module::name size
>   module: Restore the moduleparam prefix length check
>   tracing: Replace MAX_PARAM_PREFIX_LEN with MODULE_NAME_LEN
>   module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN
> 
> [...]

Applied, thanks!

[1/5] module: Prevent silent truncation of module name in delete_module(2)
      commit: a6323bd4e611567913e23df5b58f2d4e4da06789
[2/5] module: Remove unnecessary +1 from last_unloaded_module::name size
      commit: 6c171b2ccfe677ca97fc5334f853807959f26589
[3/5] module: Restore the moduleparam prefix length check
      commit: bdc877ba6b7ff1b6d2ebeff11e63da4a50a54854
[4/5] tracing: Replace MAX_PARAM_PREFIX_LEN with MODULE_NAME_LEN
      commit: a7c54b2b41dd1f6ec780e7fbfb13f70c64c9731d
[5/5] module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN
      commit: 40a826bd6c82ae45cfd3a19cd2a60a10f56b74c0

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>

