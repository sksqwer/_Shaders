struct LightDesc
{
    float4 Ambient;
    float4 Specular;
    float3 Direction;
    float padding;
    float3 Position;
};

cbuffer CB_Light
{
    LightDesc GlobalLight;
};