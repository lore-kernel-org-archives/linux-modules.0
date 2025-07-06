Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B8FBF0;
	Sun,  6 Jul 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751789758; cv=none; b=KegkGJB2cX4xOfVilrolxPgyw/NMb8rGU+lm204ZfPvn8x26efHfWez8jPxEMgVJCOvHubEg4Jfxnjj2aWvMF0LHptILFo9XRVNde7MFRv/j7DXo3nnTj5lofFIaOMIhOA1mxONAB9KJsM1veOM/UemI9U7Je3tTEgpmC8kuoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751789758; c=relaxed/simple;
	bh=Cg09FzKc18gcryfIbwrNgKGAC6DYMgEflPU1kpVNlV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MC08+NEnC0ssCFRXsC5RUcV1qggSH+Ujz64Fie9Ed/ogRW8yHo0J3rt+xkZvCvjpLDDtY+/+fEtokQRt54CS7Zn3JttoVINkxwj0WMIVcmOAgPCmjDj3IiYIRzeC6hSFcL8w8FSuoRZA/5CAfyKDUMr7GQRwmz/nOwQq40TVkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57462C4CEED;
	Sun,  6 Jul 2025 08:15:39 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
References: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: update Daniel Gomez's role and email
 address
Message-Id: <175178973757.48245.16392936460698947124.b4-ty@samsung.com>
Date: Sun, 06 Jul 2025 10:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Fri, 04 Jul 2025 21:39:59 +0200, Daniel Gomez wrote:
> Update Daniel Gomez's modules reviewer role to maintainer. This is
> according to the plan [1][2] of scaling with more reviewers for modules
> (for the incoming Rust support [3]) and rotate [4] every 6 months.
> 
> [1] Link:
> https://lore.kernel.org/linux-modules/
> ZsPANzx4-5DrOl5m@bombadil.infradead.org
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: update Daniel Gomez's role and email address
      commit: 6d6e69bd7c1c8c4f7b536a88d27d523cdee6a2f8

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>

