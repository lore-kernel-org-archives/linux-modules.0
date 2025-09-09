Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8C19DF5F;
	Tue,  9 Sep 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436334; cv=none; b=F1okDyaoEGjAwEWmiDK+fXzQr3jv5uUM2ma/wOGfvmLRCL9e8iZjS6xonLlsZyJmrNiBLjztkd9OqA/Q3ipYlOqGjaOM/wILjsSt7qaSA7pQrFxZMK2VX0bl7JVVOyXsDLwooIU0Ix5cNzwEAAF7S5XvIw6u5HBreXXGn2qV4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436334; c=relaxed/simple;
	bh=VsH0tJ6Nc+ApOcurN8vkdEVGJmPyojJ4Pixm9NB+d20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj5g21KCbADAXKrIKez/Fx8MQFsrHhIygZfg7LBlu5NQ45+n63q54YUxT9r2td/3UjGJcZEBzGbBgO7mrXXoiYi+Pc3PX07z8lRcpcKARLGnB/HVkqHHuXL8gKPflQPwSPbU+EEgRHR/W2I8CeZm8GXR/N+qMKt6gJRel4F2goQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvNmhjFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvNmhjFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593D9C4CEF4;
	Tue,  9 Sep 2025 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757436333;
	bh=VsH0tJ6Nc+ApOcurN8vkdEVGJmPyojJ4Pixm9NB+d20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvNmhjFw653RKL1xLWAhl6Khjp869kxC+uxwRnEs6kVdegErM4nOJSJwkIWETzvqQ
	 sar4f0OfyqUAk1187yi58Bazp6WFzAFXxCpwQKUGAG78yBUUlPf/P4hEMT31dW4vSC
	 LSr9u0CX1dkDSO+KmxzVa4XhHLJOkhKsbUlLzbFZqxdgj9d3/NGImX23/GnSzjgB9Z
	 9z2uFhXx5bTySKJz0gLtwkqu76n5donIlp5c4L2hi7ybLJfduV1BuVNmcro2+3ExjU
	 EcA4ck1mLtAVPzUtZw22rDEdlxOfD470Etob5VJMaWb+DL0p7F+Ks5RaU1ZcBzIxTq
	 alY5GJ3kd8qJg==
Date: Tue, 9 Sep 2025 09:45:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Fidal Palamparambil <rootuserhere@gmail.com>,
	linux-modules@vger.kernel.org, petr.pavlu@suse.com,
	da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module : fix signature checker pointer arithmetic and
 bounds check
Message-ID: <aMBZq8w1LN0unBeB@bombadil.infradead.org>
References: <20250905154550.130-1-rootuserhere@gmail.com>
 <d46498e5-db21-4a79-93b4-3869be3660d2@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d46498e5-db21-4a79-93b4-3869be3660d2@csgroup.eu>

On Tue, Sep 09, 2025 at 11:32:27AM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/09/2025 à 17:45, Fidal Palamparambil a écrit :
> > From: Fidal palamparambil <rootuserhere@gmail.com>
> > 
> > This patch fixes :
> >   - invalid module_param type (bool_enable_only → bool)
> 
> Can you explain what the problem is ? Why do you say bool_enable_only is
> invalid ? Was generalised by commit d19f05d8a8fa ("kernel/params.c:
> generalize bool_enable_only")

Christophe, I will try to save you time. You can ignore the submitter's patch.
They are a troll. I recommend you add them to your ignore list.

  Luis
