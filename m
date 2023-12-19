Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34639ADE;
	Tue, 19 Dec 2023 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FvCGhuOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AA6C433C8;
	Tue, 19 Dec 2023 20:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703019112;
	bh=BKBUXYIBYj+i0f0Vw2LEavJlPrlK8MtTyPPLU6pBIm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FvCGhuOhT1VaMyeTfhuDkqPJB7Ad4MWtQp0vOK/dJl783EUuK0cYVZkBHeaGfhtnK
	 VMrTbERrRljzdgI578umcbKmjGCJ3ke42h8hFe9NFWx4505Z4nPt+eKh2SH7HvK2VL
	 Hzt7gWOhcNcdR7NiluYs18/1aR0+wfhjtTwh1fTc=
Date: Tue, 19 Dec 2023 12:51:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Hui Wang <hw.huiwang@huawei.com>, Xiaoyi Su
 <suxiaoyi@huawei.com>
Subject: Re: [PATCH] modules: wait do_free_init correctly
Message-Id: <20231219125151.4a042a259edf3c916580ccfe@linux-foundation.org>
In-Reply-To: <20231219141231.2218215-1-changbin.du@huawei.com>
References: <20231219141231.2218215-1-changbin.du@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 22:12:31 +0800 Changbin Du <changbin.du@huawei.com> wrote:

> The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> do_free_init() into a global workqueue instead of call_rcu(). So now
> we should wait it via flush_work().

What are the runtime effects of this change?
