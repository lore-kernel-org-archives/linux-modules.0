Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022F1798D
	for <linux-modules@vger.kernel.org>; Wed, 11 Oct 2023 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2YJhSVXB"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333FC93;
	Tue, 10 Oct 2023 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8g0oB6PqYhngbYuG23JzqWL+yNnX6VYd4fp4Ba0ALOs=; b=2YJhSVXBo8Hk70GbN+zRFplRIN
	zGM21InwXmWArCXhd6WswAcoReAVxVvlwJ7NXF30XHrAB5aCuveXrDfLq+O2AGQFjTQ60EI1QfkfE
	CPpx0B01ZeFlN8KrRpdwEQwYij4VBUBqTbIMUYdeecVOzsjhwh/BtZoFEWVYtKP06IrysbHoGl7H+
	UBvMIdGfh9rBuoCMmlkBeUsyyb1aLycio61slxZ955ihO1btEUu3H2ptWM6vKEUk5/KAHS1oV+CX6
	+24loTi0LvEsEdfbylvD6JbacvJVOwS4k7X7HXUqgaUCzPhy7E+hy/asm2/k0HC0cXefZKQ368Iqc
	kKqpk4qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSsC-00F07T-06;
	Wed, 11 Oct 2023 06:39:12 +0000
Date: Tue, 10 Oct 2023 23:39:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joey Jiao <quic_jiangenj@quicinc.com>
Cc: linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <ZSZDEEBDUW5shAtY@infradead.org>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:26:35AM +0530, Joey Jiao wrote:
> When modprobe cmds are executed one by one, the final loaded modules
> are not in fixed sequence as expected.

And why does this matter?

If this is important enough to matter it should just be the default,
and have really good reason for that.  Doing something like this as
a config option does not make any sense.

