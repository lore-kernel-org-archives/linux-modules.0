Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021107.outbound.protection.outlook.com [52.101.100.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7335C69F;
	Fri, 24 Jul 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861458; cv=fail; b=WtempegnY6l3o1YT9qzrtoSGWKY3TFrUoicDDYRWxdqZW076IN2YPD62adgmV4xeuL2J+UBBusKsXUmkjBkaF0EC26z5g4FuhcdeHcwWhNaRt8/0wA724RjGQwuwnQTpW9+CIuL6a5JaVhkTsH3GlCI2JZQkkaaWBf3XLe7EWnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861458; c=relaxed/simple;
	bh=UHYuwNIY8Urh7NI2liH+o4y79wSkBv/EXsqHp8k64eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QiDuJF/hAcTXmPtsseeKmEX76cH7CRntRX6fLqEbWa9yOi+X6LUjzZneupRcP2XJXt5F22pwhucz7lI1toS5zF+RWVc9pzlYJtVag+kdlk2Rnl48ZQesb5Ft4SNu5YEWWr4gBGESdB86ZKFIMcWKBu15d6puM5BTVHGW3KN+8/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ/FawXtE6Osn4kpxSK51ZI2sWT0n8T/OOkesYlePV4UVs3ZIL6ug6iaposLl4Kgsm0VpKy2gz5gJyIAv6gFARU0PhBvFBz+zQVrpunNqMZpSytFHw/1R1QLZuMSpb58yfRJIrrT/yI6ZdJdI69un9JNV2ZuMGdGZpf6zGPOXG+fiiCb+GUAKRK88mrnyBtDSR9jm/AeE5VsQR9EGPIn/e9haxzk+sYIQ1Nm1aERpQFwynfjmwKk5uPffbiZS1L/6xozN7YSuzgl4MvDrSO2H2bjat8loS6+zedZMePqEGZ/gPJxsNjRy1TySoYGREqSsmXHFuoozekyAy3C8fSjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=VVTweATVpPQbddaN6dDohUATpY33ecwl+L8WUBbW0l8=;
 b=ZOknSBLh533yqRu5qGloyQEghwZs6W1tQyWuUS7euF8+HnE6PKzQxASkaArJ/RIKSA1h8tFYzIp0ycQSHvz0DWydRT0et/IYlhrC6coJhxpomXTxH1pYjZiNgKp1a1RoJjSnNk0Fk3K6fXbYcs0HZVpajpsi2+P0dCaFqLyD9ybvFnNJWd44+L/CfNOyy6Xx73VjmRnm2BSHWq+UkII3G2QfEPA5tj47qtXI5K692FiPMq3teTl06pwx+NEJPtcEgPL7DOKefgm0ew4Sn2JaOVT2eQFyMFV/ZKPN6QNpOPOof1T/EN+YuS4mXX27fNy0+9KaGzOrzuaMZv2+LIeokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8488.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:50:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:50:46 +0000
Date: Thu, 23 Jul 2026 22:50:43 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] module/dups: Fix use-after-free in kmod_dup_req
 lifetime handling
Message-ID: <6jyvsrlhujft23bxbmoi6bz3cvyruswyrvwzgqofaxouyazik2@btsxlulda2gd>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
 <20260723-module-stats-rcu-v2-2-bd582261fae3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-module-stats-rcu-v2-2-bd582261fae3@suse.com>
X-ClientProxiedBy: BN9PR03CA0717.namprd03.prod.outlook.com
 (2603:10b6:408:ef::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5b42c2-f806-42dd-0487-08dee92e5c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V+OKnpwJX81B+IXwGfJukoQebAonShPRiEuFJyTpVSL5DwoEaDzxFthCmysL1dx5AuATzHTm7HgxRKZsJB5apTcM7oa0PsUk6UUFFp7jqBbJ1ZCzgRURZcb45VRJWpue1QqwrWSZbFjXYXVNxie1j6HoecFAHCCJhlpUjdl2hW9ykDa95WB1IBwoBWc6RSuYSbFKiw1EyXVTrZ/vuIUA20bkjR/nNAU5wxi6O8pWnKpd3uGbRz/NngElpLwux/VKG17DNwEcmq9khxnJyjg3MDCdO1qhtcZ3f1Es4Yf/Xo7wviYEpt6EKkcSkjuKZAiQ0h8eVFwK35ArFbgxpz9beYfnCl2zgeZbdiP9bbYvPHKegQ8mJiYBsomU5u36TLh4hRpNbI8Me0XIj/nB4dmsQu/84lzbhep9E+elz5NO9J5jnG4ZqdHouOPiMX8AwAALKtP3fRdKJ68ifwXu/wxpmBsk5PK1VvfB3SxJHn5xZ1aXlFK9dQj2O+d3q+B9tuZC0sKZNjTSOWu+rmnmkGyDCYkm1rU6+y+Y5iohKTxu9nFB3pKnl+GDJA0KzXUwrlbUF67Jjq+rP6enCvbuxdHAuVpcwvtMj8jEzvQskP1M3hzq5bsE1/6nEuna8JPWZjB7zMJVewkmnS4rC6fScKFBHXHE9jdWyNzOTVFJ7D0p4dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUhGU0RhYUFrclVPTkw0czdydXRmdjc1M0NKWTYrdW5YN0pjampPdnpjSG9L?=
 =?utf-8?B?NWhKY2pncEZ2SDF6cGZ3MjZEd2E1TThCeDFKU2RWK2RWdW5yNU1iR0NPWWlC?=
 =?utf-8?B?Rm9MdHRWeGhYamk4Vm52YU42N2p6MGlKMU80MWZxNDJWd1F1VnovMG5MdjR1?=
 =?utf-8?B?R2hzakg3bERnZlVlZ0NLM0F4Yk5xWTFOVU9LWVVJQjJFRWkwbWUrSzFMSVc2?=
 =?utf-8?B?R20rQkEvOXVuV0FEQlJVSEVUazltcmU2NUpFZXJHaE9sQzM2enYyVWQwRGhm?=
 =?utf-8?B?ZUVHZUJwbmtRa2pkYyt1QjRqdkFQWENoSEpiY0I2NlpBWVIrWmxEWlMwOEN4?=
 =?utf-8?B?N2FuMW5OUEZRcE9HZ0s5RXpDeGVZaGx6UTVhT1pZQkJNalhISFhjNlYraW1P?=
 =?utf-8?B?YlZzMkxRTmxpSTR3TWkvTEp4RTlKNUFBWHdjY1lVbWhtY1M0cXN4ZFRzMTNH?=
 =?utf-8?B?VXU0NTNlRDdWUGtwQnlLVDZMVGNJb0M3U2V2ZGlrUFp0WmNibm9YbW5tTTVw?=
 =?utf-8?B?VEMxTGlYZ05SRDd2cWtTcnhJUnJkNlF6VGx2WE1YTlIzamZRZjJIYWo4Rkp1?=
 =?utf-8?B?ckFIaUlXUE9yOFE4NG1IZFdxTGluZTdHMVNnVDV1NVVTa2dMeE9EZEczQ1Y0?=
 =?utf-8?B?eW1UaUQzdGRzNjB5T2hKSlFmZDV1TFBIYmx4VEtDZlhBcnRCU1ZOMWpqd3Ju?=
 =?utf-8?B?V013NEZBRnY5YTgwMklHS2Rqbm52MUdvOXZJMmJZaG9VSVFUUUdFd0VUd1M1?=
 =?utf-8?B?dEpBUWYxOVdXN21xbzdNVFhUMmxtWXlPSHhIQko0NjJvdGdoUTBrY0tCMDVF?=
 =?utf-8?B?bStpd2h0a3I1WmNKZEVKMWxCV1RkNW1XNkVOcllpNHhlWlFHNGZNZTd6Z2Y1?=
 =?utf-8?B?MjFVRWMxZ0pMZGp1U2JzdHB0NCtCa3o0aWcwOWREOHV3T3RjLzFSVVUzYW1i?=
 =?utf-8?B?SzZkbkZ6bVJ1NER6ZysxbnVHc0g3b2tqZk9PQnloa0hQaXlUbDRDWEtLZWxE?=
 =?utf-8?B?N1B0eGR6VWY2T2EzZzV6NTE0elkrWkVrL0U1akJHUk95ckRJOTFodGo4NWNG?=
 =?utf-8?B?S0JIU0ZjRjk2cWFENGlhMHMzRnpGKzZuUWcvbitqUG1yQmJ4dmVhKzExN2pu?=
 =?utf-8?B?UHhpcVM4NExmcVpGeEdHMnoxSWtzZHp1Z3I4T1JZalNhTUFHbFRFUzFKMHNW?=
 =?utf-8?B?dTZ3UDByMkFMVm96azhycXIyMG5JOXdlK2UyZVZtQlIvZ2J3TXlZQWl3Zm9t?=
 =?utf-8?B?UVhBeFFBMEt6TGZ0SG1vdEhzeVNZdFJjdkg1UlpLZGNUeFIxWTRvd2FZUG1R?=
 =?utf-8?B?Zlk0WUR0TVgxc0Z3b0dFaEROV3FaQUFWTGcvY0hFNDRBcThtZm1pOWVvNGZ5?=
 =?utf-8?B?OEFTZnRyM2ZycEVDY204dXhIa2tEWjFobDJHck5hK285MllHdksrZXRpL3BU?=
 =?utf-8?B?T0R6cXRaby9zcElPeFJ0Nyt5VEo3aTliSzRRbmpZd1ZSVTQrNmlBUzU0MHd3?=
 =?utf-8?B?RGkyaUFHcGoyaU1oZmxucjc1cTc0MThqZjVya3dZTFRMOFhUV2ZpR0xQSXNw?=
 =?utf-8?B?c0s3Z1FvV21OUjRXMndKS1o3bFU5UW1RSmJxSkpyd21ZdTZXMmJDMjNBRUts?=
 =?utf-8?B?SnVjQUwxZzRCWXZkYThkSlRaYm1YMGYxcjZtc3F6YnIwcEFTd3h5TktzQVQ3?=
 =?utf-8?B?NnU0SHFLVE1RRDlNeEx6emRrYjhYWGFOR0pXczlkZ3QrdFdseCt3dlM3L3lV?=
 =?utf-8?B?Nm44MmVGZnZnNzhJQXVQN1pDWUlzUFg1ZzlQa3N6SC94elFSdmU0cld4azNx?=
 =?utf-8?B?T0dVei9wSk9PM2hGWFFYRXNzQ1ptNURKOFUxYUF4Y09XYm14aVpSS3BFMmVy?=
 =?utf-8?B?amxXR0xCUEwvTkc5OVJBR2FBQVZOOWpiY2U5RmQrVFVVSGw2ckdoNmN0Sm1k?=
 =?utf-8?B?c0dGNGJqb1VWZkRZTzROT1BFdGZNUzE2SzZhVll1SmJYVDdCSGtabXpsSld5?=
 =?utf-8?B?dzdaZ2lXVkZlaWI3Zm1EeDEvazdyV3RkdlZrYUgyUTRnSm1XTGFBOHdDZ2ZD?=
 =?utf-8?B?V3B6aHR3NndobHZWS2IxakxCZXY1NWxVTUtjRk9lMmVPSHljUjZLR0o1KzVx?=
 =?utf-8?B?bVdHQmZBRlVGbCtpd2c2MW1EVllidXBrNUN4eFlZc1grV1JiM1pNVFlLT2ZF?=
 =?utf-8?B?Q0E2cWdnUHNEYUkwZVRDVHJERkdRcHNXL2swcEh3ZFMzZk5ha2tMdlpvOXFD?=
 =?utf-8?B?ZGZiV0hMalU0SjJKbXFyU2gxajlsRUdqZERrck1HQjh1Umhnd2p3VXhGTTcx?=
 =?utf-8?B?UE9FQVl2THRwM2p2TDQrMTVsc3JKNUFPRGpoaFZjbHpLcjhjdkIxZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5b42c2-f806-42dd-0487-08dee92e5c7d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:50:46.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHzHyxJiMlMg81E+e8HWPS7Et0C/qFUGfaaFiN3vbnUlTloUUgsCrDvvwyKd7abNmUY9mjyGXYQ7DKpC3zyr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8488

On Thu, Jul 23, 2026 at 10:25:52AM +0200, Petr Pavlu wrote:
> The kmod dups code uses RCU to ensure that a kmod_dup_req instance is freed
> only after it is no longer referenced. When releasing an instance, the
> kmod_dup_request_delete() function removes the kmod_dup_req from the
> dup_kmod_reqs list, waits via synchronize_rcu() and finally frees it.
> However, this doesn't work correctly because parallel users referencing the
> instance in kmod_dup_request_exists_wait() don't enter an RCU read-side
> critical section. This can result in a use-after-free.
> 
> The kmod_dup_request_exists_wait() function may need to hold a valid
> reference to a kmod_dup_req instance across a blocking wait until the
> corresponding modprobe command completes. This makes it unsuitable for RCU.
> 
> Fix the issue by changing the lifecycle management of kmod_dup_req to use
> reference counting.
> 
> Fixes: 8660484ed1cf ("module: add debugging auto-load duplicate module support")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/dups.c | 56 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 16 deletions(-)

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
