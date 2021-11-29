#include "000_Header.fx"

texture2D BaseMap;

struct VertexOutput
{
    float4 Position : SV_Position0;
    float3 Normal : Normal0;
    float2 Uv : Uv0;
};

// VertexShader
VertexOutput VS(VertexTextureNormal input)
{
    VertexOutput output;
    output.Position = mul(input.Position, World);
    output.Position = mul(output.Position, View);
    output.Position = mul(output.Position, Projection);
    output.Normal = mul(input.Normal, (float3x3) World);
    output.Uv = input.Uv;
    return output;
}


float4 PS(VertexOutput input) : SV_Target0
{
    //return float4(input.Normal * 0.5f + 0.5f, 1);
    
    float4 diffuse = BaseMap.Sample(LinearSampler, input.Uv);
    float3 normal = normalize(input.Normal);
    float NdotL = saturate(dot(normal, -LightDirection));
    return diffuse * NdotL;
}

// using Direct11
technique11 T0
{
    pass P0
    {
        SetVertexShader(CompileShader(vs_5_0, VS()));
        SetPixelShader(CompileShader(ps_5_0, PS()));
    }
}