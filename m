Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792502067;
	b=4S1h3e4eiqTIIo9GL0nddHtMtqzYItp6N/ZtDXNQzogkcToVBmfW84owBRuxOj7s8P1U
	 G0sm1UIzXn11+FZ++ixVrmvIisa7BlCzf2m6F97ZJYAKT5dZy2z+wKs74V2XcaBTE+Jxn
	 egK7o9gn60GSI6psM6RDMKpQf0yjx+3mkfZj+9C0CGsQZexW2sADdMF8gArJVb+Vj/1D4
	 XXtPb/UpDGLM8TdDV97kCQwJv6kPU4XbpQQrGI+E6PTQIF3LHIQHkaECnbYfNK+bzNLyX
	 ejOqL0NqsjScEM1sXCOZ89P3QIk7ufaWYqvA7JOnSHdu3eClLzsO20VGFXBvbhk0M2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502067;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SSVYrQpQnaO/XPo/xpdJ1Ju/M/k3rJSQE3X6WGXXql0=;
	b=l4MU7pSo0hXE5KqbCG3fV1jI77rvS+NLu9k8C4C4gDRRCN6EB98Y3JjZ7JiS6ifFnNio
	 MOx9l3gxDaoTRL++nBAUcsKRXZki+0u5r+5q5ZLuEmn56q3c20VrNeFqIBQ23q+5FG+C4
	 X8D9LW1N8LYYkRRPqG2seK+jbFcLUhhpvjSMH4VXjyKWY2Xruv0c7QumiQb4EUXWzyvWT
	 1DBWAVZClAwGIFlSfamMIk5jfQ9WAzsb0rHtdPDvBL8t77JI/RlnDTrX1C8xVWC/nqn32
	 vezxCu8ONQFrg4YZcSBEUa9UfbuMX37KiZLEM0SzBn12//lYEXmNk0Zmp9IZqQAOkwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BocoeYVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE920606A319;
	Tue, 20 Oct 2026 13:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE920606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BocoeYVs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTsj7kdxRcg34rv9D6EmbSr8YoWvvDCJc00jk989QtOIox6lfdh6kXRCYGctxNgUYe2n2+lLSCP8PM2vMFfgMQ2iTbtccFMaG8zbfNiTegnNNGL6oovdbmPm4zkb8cNtCi3zl95I6pWQ9n8AGos0iSVeBzfvt43CWWwAqdhsa8600GeZkdxPccN7GjKvDIBPAM9CqIW9FaVlkLuLLZhkxYzNYJXLS29OshY4kqvHy8rNBYBV/IalvbwJsCHNOKpUn0zvJnZGhEBKIjAgLkngtgneRNrw4L4AsXgXHyUMV9J/r3R6mTFKuAgN5cxknuWTcyUCnIRE3N/Z3/vjum7LnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSVYrQpQnaO/XPo/xpdJ1Ju/M/k3rJSQE3X6WGXXql0=;
 b=bcN3A8UxLg/SVk63EF4okeqCHXtcdydHozj5EKEy6wt2vivputycqnKezOTg1z9Ug7nGSh0w6NUjh8VpqNymw0lbbolc3uDGExyv9uDjhPjU8Eul92fMo2FZM47Q7cF581aQwpWfCsV7Qohc5uwYc2ylMjL61xVuvmifsQbt517obBfpIL4tMwJ9UkYKDDYuxbx85pvHHJZERUnkvqo3EclLBDGYJ1bXYoJsuxN6EkovDnTxHvttsqTx6rYseOE51u1HtyoSZ5yC+KHoAuDNz6n3xWVvuKg70pMjf7SqJwZ4v/9PL8h8kBAQEO7VzNJTJKTI0/hJ9BKKI6Jzh2ujMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSVYrQpQnaO/XPo/xpdJ1Ju/M/k3rJSQE3X6WGXXql0=;
 b=BocoeYVscGpm3QB7NAMLQEPydfMyO0Pc7zLZx5KvANycQV/S25ONE0ApIktv+8I4XmYScXc66lSnIgSvFIqgIKqrVaIikEl8SFTRHFBVLAVItGqjLWrUjnbgglU2YRW26Vtsu7+4O35RK36/klNxZI1ayDwuJH19PvV69NbTP/XMUb5zSnF9Jcimo0WdREJcE/gY0BVUjZZuN1ZD7WgBUbvUH1qNPUI+urvN9ej8fr4dduoquz6kAazlJ/B++PWNTsbQJPeiT1kUlFUrMNtOTTr9w3BhvZ3Ad7QpQW5+Tk4BxolmQyfPiq4bOgE6qrnnYeN4pW1Le7426PDY8PPaVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:14:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:14:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 22:14:12 +0900
Message-Id: <DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>
Cc: "Jason Baron" <jbaron@akamai.com>, "Jim Cromie" <jim.cromie@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Will Deacon"
 <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Lyude Paul" <lyude@redhat.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 00/11] rust: add support for dynamic debug
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
X-ClientProxiedBy: OS0PR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:604:1c5::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a85c524-c138-43fe-d67e-08df2eac0a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ijSj5Ve2M60gqKg82f+FNbnAlO89Ozk4qFgdhrNNq3ZSimJcWAj2qfwUUA14M5SV5f0vXMpLGKi1tt/vTIdtUyF6A0G5Y5F1rTsEt8hwsnOZdNwb5fNyU439IffTSTlqaOkHH7WtM8GunS95YKpqFCKqWtqeB+mNprwVpbBRQ3sv6HhIkW+R2F2mnjpYzR39/a9HCR6/gDXKHwMyRELPrKSFMf/64YikzK/vZcuScPdZtuDvU5L7q4skCz7upcat4w4RITHxOaMskO5hFsBOjsa8qZJv3nXSiV/kKWg/isl755rvuee2MhEU2a9FUZg8gt9h0zXxxBYed4YS+9QQ0fbOZQruZCmIrx8DtQNgfusBoi5o1ZrhGoQZL0Vf5Mc/c74VPeVTJYbhTgdK/cPRED9ANoCRuwdChRnGzpMXF2Hn58gOg28BYknyoK172d+r8dQh95l/rjTfOhq+MpSShMPCC2SteSbIIBIYu66tAcknEhRQrFKHUBWIgVCoQB8dSQBaPwN/lTyAbhB31V4OGqj4eLAiamfA4syghdyyDyN/ttJsYjdXXqzR+HJZDZQog9AwU3W94dgRPjk0s9bEnBuwvhtZjutzM56jUuRrhDTCsNQAqTp3Xv0oTCjtBtjwP5rNcQbJyqCFzSflJBLP+KpNoojIqQQv7b1oscnTHNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZlVjFnNEE3TmdUYXpSZ0RtT1VZeVhOOU9wdW05d1N0MWNyQmpoU01kTVk3?=
 =?utf-8?B?cTBaRGE4K3FLcDBxY0R3NVpaQzhNTWh0RnhFdGJrZVpwemN0SE80ME9wOTRt?=
 =?utf-8?B?ME5OSnc0OUdKSUVWY1RFUDV3cVljNlJOK3dObW9aWGFGcmhxYmwwQVZCN0Q5?=
 =?utf-8?B?QkNINWhLTFFBSmVkTlZIM1pQWXE2QVFTWmhEY3JBYXQySjVjRmlTczNJUVk4?=
 =?utf-8?B?a1E1VEtqVlUwWW9mSGZZejhHN1RoME5YTTBpTHFPellpWnpjUFd6K0YxMmZZ?=
 =?utf-8?B?cHZueHBVRUhLVnNZeHBlUXc1THZ0MGtsZXhHTTZTYzFqQ01tR1Q2V2NITGNI?=
 =?utf-8?B?d0VhcXcyTkxCV29lSTJPTm1HeHVxQ1BtTVAxNnQ5bS9CTGtQdzhmWGJUZ0ZI?=
 =?utf-8?B?WWdvK0xBTGZ3TVFDV2F3cUVmcU1iZEVoalQ2SjAxN01aa21Vby9lUmNicThp?=
 =?utf-8?B?R2xmMElwQ084K3dnZ29ib2xLMkZRWUtzbnBQbncvbDhGdFZibGs0anVhL0lP?=
 =?utf-8?B?STRGcndIUzBXc3hSbGNPVllDZGUvZHovUENzNnJaWFhHZjI3K2Frd3BWS2tC?=
 =?utf-8?B?ZWx0Z0xQbi92dlAxV0tVM1ZrRnpSbGtQbkd2cFovRDZrbUtNUlhKVFBqRVF6?=
 =?utf-8?B?alBhWXRVMzdtZFd0dkl0bDk4ZFNYanA4R0VoUU9sOHBhV2hRa3QvVnEwWTFO?=
 =?utf-8?B?OTNWQVNEaUx0Z0JnWjI1WGx5K3hJVWU0SFRNSGhFaDBIMVBZODRnT1lpblBv?=
 =?utf-8?B?Yk1GQzc2TmZDNzhIbnlvRlV1MWliTE5Sd3VvWnE0djNYcTc2VjVDUjNnbVFH?=
 =?utf-8?B?TEpYZDBmUVpsdXVnQjRneXdHS1hVUGp6aENNV1BqYWRlbHNWeHlNRU51WUhL?=
 =?utf-8?B?VFlEbmFxb3R5NGpSeEdsdlZzdUZ0dmNqUU5XaVYwWVpVaTg0N0RoZk9zZ0hZ?=
 =?utf-8?B?S1pBaTRYRms0YWpZVTJpR0RrZUp5UVVWL0hUcVNBLzM5eWVwR3RnL3dDNU85?=
 =?utf-8?B?bTcwTzRSMTRqdnovbkwvT2t6RFNXUUI3M2w5MUhhei9OVDQvUGVCL2VaMUZI?=
 =?utf-8?B?dlA2N3llanVHWFNuSS82MkRSTnJnWEMyZ0dVNUJpNVo1SHNuMFA2VWQ1RnBz?=
 =?utf-8?B?dUZ2dzgwTDRGTkpjNk5ISEZpbVlwTWRPQ3dyVXkwRGNHalJpWDVNN2ZoRkc1?=
 =?utf-8?B?OHRrTXkyN0tmRkl4bkU4eitjcWxRSGpsdjQ2SWZvY3h6c1pzVjhsdkw0ZVM4?=
 =?utf-8?B?VDBVVjhWaTlEWTBrbVg2eStzZVA2VlJlR2JiZlpPcWRFZkgzL1FQNGpDL3M3?=
 =?utf-8?B?Q0orcDljK2E2V0U4aWtHQUEvZ2NxaE1LMzh0Um5LczNPeFRuNXo4dm8xRWgr?=
 =?utf-8?B?d2xveFF6YWtIb01td01UcGpUVVJvQXJNdHluTkdCRTN2N2l0bzhSVm5LalIw?=
 =?utf-8?B?dStxQVp2TUJjWW54TWpmSHRhbjN2MDEzcmJLYS9kKzZRcFB6VTNvNUV4NzVl?=
 =?utf-8?B?SElmd3N3TC9YejdJU1dUMEV5ZWR0Q3hmdnRMT0owQWtjY1BvcTFZYU9VcEZm?=
 =?utf-8?B?cmxkVHNSWXpwN2dBWnFsRWw0VkR0VWNyZ0J2K24rREw5cjJGQmNZWVc2OWVq?=
 =?utf-8?B?NEp4RlVQYWdKa2l3cXNLK0tKeFc3YlNnSFpKY3RsL3FoL2hSclpGTkhnUkdm?=
 =?utf-8?B?dDVERzQ0THFISE0wKzc4VDZUZk1VVUtkbmJCT0dXZ0ZNS2JBdzlkZi8xclRU?=
 =?utf-8?B?WHA0ekw4RkZyNUtOeDAySUhieXJEZG1Kb1ptZkRFMFpQWjBYQmwrTmRIc1ZR?=
 =?utf-8?B?LzFSMU1uZ20zaFhyU2lGNjhjR2J3VEpSQ2lYMUVMNEtnZGhOK1NjMkhyVVFF?=
 =?utf-8?B?VHUyaVhKbnpFMFpmMEpSRWJnRUErcnEybHFDbUs1THFFVE9Qci9LU1UwUkRj?=
 =?utf-8?B?SmZHb3I5dHFMam9oRDBlblN1dW56NUZaZ2Q4c0x0REFOWDIreEF6RkwvcHlP?=
 =?utf-8?B?dENQT2NhdURhQlhHYVZtRTFkRDlBeHV5eVdPL0tHcG1DMTNXVGkvUms5bmxK?=
 =?utf-8?B?b09pdFZNVFhXaUZST254SHVqQlRyN014MVZOUVZGM2IxRTRPOHo3cTRvNThP?=
 =?utf-8?B?MWEyd3hGS3V3QXlDZzdiQmgyemJYRjliRUJ6bGFpY0dHY3ppTFl5VWVBdzFL?=
 =?utf-8?B?VEl5cDZjWmQ3c1RUMlhCMlp3N20zcm0rMEdGdUVYQklhQkFISXp5QU1zTlFN?=
 =?utf-8?B?SlpEMHhZZVROd2FKR1RBdXlzUDZ2aFdOYlY5cHBES1B2a0QyWFg2azNsc1lj?=
 =?utf-8?B?enlRUzN6YUd6Z1lMVkdaaSt0b0c4emw4Qm1MSXUxU3lZTzNja1ZTUnAxN3Ny?=
 =?utf-8?Q?qZ7fiy6rA6Dib9VUAlBT5QyQEbkOQrVZ9BxgAAPKpbqwA?=
X-MS-Exchange-AntiSpam-MessageData-1: 4PyVtvBYN+HKLQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a85c524-c138-43fe-d67e-08df2eac0a5e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:14:15.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOeVQmqvRA3TjHpXpVZt0NrP1k9HNDTjDm9pQ5GrADClYbBSzh2HFAFK0U5vLPyKtkudrO/4IdWPEDR2UH4Ebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

Hi Thomas,

On Sun Oct 11, 2026 at 9:52 PM JST, Thomas Wei=C3=9Fschuh wrote:
> Add the Rust infrastructure to integrate with the dynamic debug
> infrastructure.
>
> Static keys are not used for now, as the full bindings are missing
> for those. A follow-up series will add that.
> Also custom classes are not supported yet, but could be added on top.
>
> Patches 1-4: Generic Rust preparation patches.
> Patches 5-7: C dynamic debug preparation patches.
> Patches 8: Rust Dynamic debug infrastructure.
> Patches 9-11: Rust Dynamic debug enablement.

Were you aware of this series [1]? There seems to be quite a bit of
overlap.

[1] https://lore.kernel.org/all/20261001145940.1077801-1-zhiw@nvidia.com/
